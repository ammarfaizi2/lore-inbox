Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270275AbTGMQhX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270281AbTGMQhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:37:22 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:17668 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S270275AbTGMQhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:37:09 -0400
Subject: [2.5.x] doesn't boot at all on one computer
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1058115160.2200.7.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 13 Jul 2003 18:52:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

I've got an issue where 2.5.74 (and all previous ones, tested until
2.5.72) don't boot for me (and I didn't test 2.5.75 because it won't
work either). The config is known to be right, because it boots fine for
other people, it boots on other systems, and I've booted previous
kernels (up to 2.5.67) with the same config earlier on. I've tested
three configs in total, one where everything needed to boot is in the
kernel (that one worked in 2.5.67 and earlier), and another similar one
(which boots fine for other people), and another one copied from my
2.4.21 kernel (and yes, VT/VGA/CONSOLE etc. are all set to 'y'). I've
tried both with and without FB enabled, and in all cases, I get either a
black screen or I get grub's message telling me that it's about to start
booting the relevant kernel image, and nothing after that.

In short, I have no clue what could be wrong, but since the exact same
configs work for other people and worked for me in the past, I'm
guessing there's a conflict with some recent patches and either my
compiler (well, gcc-2.96 isn't really ideal) or with some hardware
specifically in that machine. I cannot tell which of the two, I don't
have another compiler there. I'm trying to find out if anyone has seen
similar things on similar hardware. If not, I'm willing to test with
another compiler, but I'd rather not (I hate messing around with all
that on my system).

First, software:
RedHat-7.3
gcc-2.96-113
module-init-tools 0.9.12, 0.9.13-pre and 0.9.11 (tried several of 'em)

System:
P-2 400 MHz and P-3 500 MHz (I had the p3 lying around and swapped them
to see if it was the CPU, but both didn't work)
Intel 440BX-based mainboard (Abit BH6)
256 MB RAM

Relevant lines from grub.conf
title Red Hat Linux unstable (2.5.74)
        root (hd0,0)
        kernel /vmlinuz-2.5.74 ro root=/dev/hdc1 hdd=ide-scsi noapic
        initrd /initrd-2.5.74.img

I've tried without the initrd, I've tried with vga=792 (for fb support).
I've also tried without the noapic, I found the noapic suggestion on one
of the 2.5 FAQs around on the net (without it, my networking card didn't
work in 2.5.66).

config files:
http://213.197.11.65/ronald/config-2.5.74-initrd
http://213.197.11.65/ronald/config-2.5.74-worksfor66
http://213.197.11.65/ronald/config-2.5.74-worksforothers

the initrd one uses initrd, the worksfor66 has everything needed to boot
statically linked in, so does the worksforothers. The first of these two
was tested with 2.5.66, 2.5.67 and some earlier ones and booted fine
there. The second one was copied from someone else trying to help me
with this issue, and worked fine for him.

Well, this is about all the info I can give here, I'm affraid. Anything
more I should try? Anyone recognizes something similar, maybe with a
solution? Any help is very much appreciated.

Please [CC] me, I'm not subscribed.

Thanks,

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

