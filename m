Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTJCHEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 03:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTJCHEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 03:04:30 -0400
Received: from aneto.able.es ([212.97.163.22]:12968 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263554AbTJCHE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 03:04:26 -0400
Date: Fri, 3 Oct 2003 09:04:22 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-hfsplus-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
Message-ID: <20031003070422.GA8627@werewolf.able.es>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0310021029110.17548-100000@serv> (from zippel@linux-m68k.org on Thu, Oct 02, 2003 at 10:37:32 +0200)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.02, Roman Zippel wrote:
> Hi,
> 
> This is a rather big update to the HFS+ driver. It includes now also an 
> updated HFS driver. Both drivers use now almost the same btree code and 
> the general structure is very similiar, so one day it will be possible to 
> merge both drivers. The HFS driver got a major cleanup and a lot of broken 
> options were removed, most notably if you want to continue using netatalk 
> with this driver, you have to fix netatalk first.
> 

Two notes:
- You should give a patch or at least give a notice that linux/include/hfs* have
  to be killed (or move hfs_fs.h there).
- I had to include linux/sched.h in hfs/sysdep.c to get the definition for
  'current', that was neded in some subinclude of linux/smp_lock. This can be
  caused by any other of my patches, but it doesn't hurt.

TIA 

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre6-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
