Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSAVRPp>; Tue, 22 Jan 2002 12:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288028AbSAVRPf>; Tue, 22 Jan 2002 12:15:35 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:9104 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S287134AbSAVRPU>; Tue, 22 Jan 2002 12:15:20 -0500
Date: Tue, 22 Jan 2002 18:15:16 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] amd athlon cooling on kt266/266a chipset
Message-ID: <Pine.LNX.4.40.0201221801210.11025-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there!

a few month ago someone has posted a patch for enabling the disconneect
on STPGND detect function in the kt133/kt133a chipset. for those who don't
know what this does: it sets a bit in a register of the northbridge of the
chipset to enable the power saving modes of the athlon/duron/athlon xp
prozessors.
i did not found any patch which enables this function on an kt266/kt266a
board. so i modified this patch (
http://groups.google.com/groups?q=via_disconnect&hl=en&selm=linux.kernel.20010903002855.A645%40gondor.com&rnum=1
)
to support the kt266 and kt266a chipset to.

now i am looking for people to test the patch and repord, whether it works
allright on other computers than my computer (i tested this patch on an
epox 8kha+ whith an xp1600+).

if you want to test this patch:
1. first apply the patch
2. enable generel-setup -> acpi , acpi-bus-maager , prozessor
   in the kernel config
3. add to the "append" line in /etc/lilo.conf the "amd_disconnect=yes"
statemand (or after reboot enter at the kernel-boot-prompt
"amd_disconnect=yes")
4. build a knew kernel
5. report to me, whether you have problems ...

if the patch gets a good feedback, maybe it is something for the official
kernel tree ?

daniel

# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

