Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbTEHV7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTEHV7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:59:40 -0400
Received: from aneto.able.es ([212.97.163.22]:54262 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262160AbTEHV7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:59:37 -0400
Date: Fri, 9 May 2003 00:12:02 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Brad Boyer <flar@pants.nu>
Cc: "J.A. Magallon" <jamagallon@able.es>, Roman Zippel <zippel@linux-m68k.org>,
       linux-hfsplus-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] HFS+ driver
Message-ID: <20030508221202.GE3458@werewolf.able.es>
References: <Pine.LNX.4.44.0305071643030.5042-100000@serv> <20030508213401.GA3458@werewolf.able.es> <20030508214746.GB19450@pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030508214746.GB19450@pants.nu>; from flar@pants.nu on Thu, May 08, 2003 at 23:47:46 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.08, Brad Boyer wrote:
> On Thu, May 08, 2003 at 11:34:01PM +0200, J.A. Magallon wrote:
> > How about this ?
> 
> Yes, this is a good patch. I originally started on 2.2.x, which
> doesn't have strsep, and I didn't trust strtok (with good reason).
> I'll get rid of my little hacked up function and use strsep instead.
> Thanks for taking a look at the code.
> 

Just by chance... I was looking for options...

BTW, i could look for it but perhaps you know the answer. I use a zip
to move files between osx at the uni and my home linux. I have always been
hit bit the short name length in hfs. Does hfs+ increase it ? If not, have
you been able to read UFS filesystems created on osx with Linux UFS ?

And finally, while we are at it, I also did some other changes, some aesthetic
and some needed to patch on top of 2.4.21-rc1:

- Changed a bit the description strings in Config.in and Configure.help to
  uniformize HFS and HFS+.
- Moved HFS+ next to HFS in Configure.in
- Killed your new_inode() macro, that function is already in -rc1 (yup, if
  you want to maintain backwards compat, it would be better to wrap it
  with a LINUX_VERSION_CODE < KERNEL_VERSION(2,4,???), since when is
  new_inode() in ?)

Modified version, including the hfsplus dir and the 64 bit changes, is at
http://giga.cps.unizar.es/~magallon/linux/hfsplus-20030507-2.bz2

Can you check it ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc1-jam2 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
