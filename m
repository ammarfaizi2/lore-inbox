Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269689AbUICNWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269689AbUICNWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269675AbUICNUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:20:02 -0400
Received: from mailgate.urz.tu-dresden.de ([141.30.66.154]:32144 "EHLO
	mailgate.urz.tu-dresden.de") by vger.kernel.org with ESMTP
	id S269690AbUICNQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:16:55 -0400
Message-ID: <1094217393.41386eb16f9ee@rmc60-231.urz.tu-dresden.de>
Date: Fri,  3 Sep 2004 15:16:33 +0200
From: Hendrik Fehr <s4248297@rcs.urz.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc input/output-operations
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 217.238.206.14
X-TUD-Virus-Scanned: by amavisd-new at rks24.urz.tu-dresden.de
X-TUD-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on rks24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> [...]
> Likewise. So it is booting up with DMA enabled and ought to be fast for
> both devices. What does hdparm -t /dev/hda say ?
> 

bash-2.05b# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:   72 MB in  3.03 seconds =  23.80 MB/sec

Note: i just added "noapic" to my boot options.

bash-2.05b# cat /proc/cmdline
BOOT_IMAGE=bk8dev26 root=305 psmouse.proto=imps hdc=cdrom ide0=ata66 noapic

I dont know if ~24MB/sec is a good speed, but remember: the cpu is on full
usage
and the BUFF memory usage increases (and is later released again). And as i
wrote to Lionel there seem to be a linear dependency between cpu clock rate and
i/o result. Lionels words to this fact: "There seems to be an unusual amount of
cpu time spent in IRQ processing for your disk drive's accesses but I really
can't put a finger on why."

BTW: those who dont know: i made a nice "bug"-report and put it on:
http://rcswww.urz.tu-dresden.de/~s4248297/gubed/report.html
You will find all the interesting things like dmesg and hdparm -I /dev/hda
output in the "files" section.
