Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUGYQiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUGYQiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 12:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUGYQiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 12:38:25 -0400
Received: from lakermmtao09.cox.net ([68.230.240.30]:51423 "EHLO
	lakermmtao09.cox.net") by vger.kernel.org with ESMTP
	id S264213AbUGYQiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 12:38:22 -0400
In-Reply-To: <200407250943.05592.gene.heskett@verizon.net>
References: <200407242156.40726.gene.heskett@verizon.net> <200407250012.52743.gene.heskett@verizon.net> <200407250909.00227.vda@port.imtp.ilyichevsk.odessa.ua> <200407250943.05592.gene.heskett@verizon.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0A8CE086-DE59-11D8-9612-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: 2.6.8-rc2 crash(s)?
Date: Sun, 25 Jul 2004 12:38:21 -0400
To: Gene Heskett <gene.heskett@verizon.net>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25, 2004, at 09:43, Gene Heskett wrote:
> Humm, maybe I missunderstand you:
> [root@coyote linux-2.6.8-rc2-nf2]# objdump -d
> </boot/vmlinuz-2.6.8-rc2-nf2>.o >file.objdump
> objdump: a.out: No such file or directory

Heh.  You aren't supposed to put the angle-brackets around the file.
The shell reads this like thie following:
# cat '/boot/vmlinux-2.6.8-rc2-nfs>.o' | objdump -d >file.objdump..
Then objdump doesn't get an input file, so it looks for the default
input file, "a.out", which it can't find.  Just write it like the 
following:
# objdump -d /boot/vmlinux-2.6.8-rc2-nf2 >file.objdump
Or the following:
# objdump -d dcache.o >file.objdump

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


