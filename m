Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135427AbRDMHAL>; Fri, 13 Apr 2001 03:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135428AbRDMG77>; Fri, 13 Apr 2001 02:59:59 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:6412 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S135427AbRDMG7m>; Fri, 13 Apr 2001 02:59:42 -0400
From: Jan Gregor <J.Gregor@sh.cvut.cz>
Date: Fri, 13 Apr 2001 08:56:23 +0200
To: linux-kernel@vger.kernel.org
Subject: bug in kernel 2.2.19
Message-ID: <20010413085623.A280@pisidlo.sh.cvut.cz>
Reply-To: J.Gregor@sh.cvut.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
 Kernel 2.2.19 downloaded from www.kernel.org sometimes when I boot from lilo
reports after "uncompressing linux ..." and blank line shows "crc error"
and halts. I looked at the sources and found that this means that uncompressed
kernel has bad crc. I tried compile it under debian potato (gcc 2.95) and
redhat 6.1 (egcs 1.1.2) but result was same. Kernel 2.2.18-pre21 too sometimes
halts (compiled on debian) but after "uncompressing linux ...". I think that
it is a bug because kernel 2.2.16 never halts on startup like 2.2.18 or 2.2.19
(it actually never stops on startup).
 My board is tomato 5dhx (intel hx chipset) and cyrix 150+ (revision 2.6).
Graphics is s3 trio64v+, ethercard 3com 509b and soundcard olp3-sax.
 Bios doesn't set processor on startup (sleep on halt instruction, avoid
comma bug and things like these). It is interesting that when I boot from
loadlin this things (with 2.2.18pre21 and 2.2.19) never matter. I looked
at the autoexec.bat I found that I set here cyrix (sleep on halt ...).


                                                    Bye, Jan Gregor
