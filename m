Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVAQEtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVAQEtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 23:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVAQEtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 23:49:50 -0500
Received: from ahmler2.mail.eds.com ([192.85.154.72]:54443 "EHLO
	ahmler2.mail.eds.com") by vger.kernel.org with ESMTP
	id S262688AbVAQEtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 23:49:14 -0500
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF41050157A12B@usahm236.amer.corp.eds.com>
From: "Post, Mark K" <mark.post@eds.com>
To: "'Randy.Dunlap'" <rddunlap@osdl.org>
Cc: "'Linux390'" <linux-390@vm.marist.edu>,
       "'BOEBLINGEN LINUX390'" <LINUX390@de.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Discrepancy between ftp.kernel.org and linux.bkbits.net
Date: Sun, 16 Jan 2005 23:48:52 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, you're right.  Something (else) strange is going on, though.  I was
having problems with Comcast's DNS servers not working earlier tonight, so I
had to substitute the IP address of linux.bkbits.net (192.132.92.3) for the
name in my web browser.  When I use that now, it does _not_ show the change
having been made.  If I use the DNS name, (Comcast's back to working again),
the change is absolutely there.  Very odd.  Ah, I just happened to think
that perhaps some virtual host stuff is being done in Apache, and you don't
get to the same place if you specify an IP address versus a host name.

I guess that's an interesting lesson to learn, but certainly nothing that
LMKL has to be concerned about.  Thanks for the response, I'll go away now.
:)


Mark Post

-----Original Message-----
From: Randy.Dunlap [mailto:rddunlap@osdl.org] 
Sent: Sunday, January 16, 2005 11:05 PM
To: Post, Mark K
Cc: 'Linux390'; 'BOEBLINGEN LINUX390'; 'linux-kernel@vger.kernel.org'
Subject: Re: Discrepancy between ftp.kernel.org and linux.bkbits.net


Post, Mark K wrote:
> I believe I've discovered an odd discrepancy between what is in the
official
> Linux BitKeeper repository, and what is on ftp.kernel.org.  According to
> BitKeeper, the last time linux/arch/s390/config.in and
> linux/arch/s390x/config.in were changed is 17 months ago.  What is in
> ftp.kernel.org/pub/linux/kernel/v2.4/linux-2.4.28.tar.bz2 was last
modified
> on November 17, 2004.  The difference between the two versions is this:
> @@ -57,7 +57,7 @@
>  bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
>  bool 'Sysctl support' CONFIG_SYSCTL
>  define_bool CONFIG_KCORE_ELF y
> -tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
> +bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
>  tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
>  bool 'Show crashed user process info' CONFIG_PROCESS_DEBUG
>  bool 'Pseudo page fault support' CONFIG_PFAULT
> 
> 
> Admittedly, pretty small, but still disturbing to me, at least.  What's
> interesting is that this change seems to have been made to a _lot_ of
> architectures (14 in all) in patch-2.4.28-pre2.bz2, which is now in
> ftp.kernel.org/pub/linux/kernel/v2.4/testing/old/  That file is dated
August
> 26, 2004.  This same change was included in -pre3, all the way through
-rc4,
> and then the final 2.4.28.  The entry in the patch-2.4.28.log looks like
> this:
> Adrian Bunk:
>   o 2.4.28-pre1: add two SATA Configure.help entries
>   o disallow modular BINFMT_ELF
> 
> Does anyone have any idea why this didn't make it into BitKeeper?  Should
it
> be in BitKeeper or not?  This looks like some sort of process failure (or
> failure to follow the process), which is what concerns me the most.

Browsing bkbits.net shows that it is there:
http://linux.bkbits.net:8080/linux-2.4/diffs/arch/s390/config.in@1.14?nav=in
dex.html|src/|src/arch|src/arch/s390|hist/arch/s390/config.in

so a 'bk pull' doesn't show it??  (I can't verify yes/no on that.)

-- 
~Randy
