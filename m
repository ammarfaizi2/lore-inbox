Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUBIOSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 09:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265231AbUBIOSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 09:18:22 -0500
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:8437 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S265224AbUBIOSV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 09:18:21 -0500
Date: Mon, 9 Feb 2004 15:18:18 +0100
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc1-mm1
Message-Id: <20040209151818.32965df6@philou.gramoulle.local>
In-Reply-To: <20040209014035.251b26d1.akpm@osdl.org>
References: <20040209014035.251b26d1.akpm@osdl.org>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Andrew,

On Mon, 9 Feb 2004 01:40:35 -0800
Andrew Morton <akpm@osdl.org> wrote:

  | 
  | 
  | ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc1/2.6.3-rc1-mm1/
  | 
  | 
  | - NFSD update
  | 

Starting with 2.6.3-rc1-mm1, nfsd isn't working any more. Exportfs just hangs.
Previous version (2.6.2-mm1) worked fine.
Reverting the following patches makes it work again:

nfsd-01-schedule-in-spinlock-fix.patch
nfsd-02-ip_map_init-kmalloc-check.patch
nfsd-03-sunrpc-cache-init-fixes.patch
nfsd-04-convert-proc-to-seq_file.patch
nfsd-05-no-procfs-build-fix.patch

You can find my .config here:

http://philou.org/linux/2.6.3-rc1-mm1/config-2.6.3-rc1-mm1

You can find an strace of the nfsd server startup as well as a sysrq-t capture here:

http://philou.org/linux/2.6.3-rc1-mm1/nfsd-sysrq.txt

System is a Dell 2650 SMP (ia32), running Debian Sid.

Thanks,

Philippe

--

Philippe Gramoullé
philippe.gramoulle@mmania.com
Senior System and Network Architect
Lycos Europe

