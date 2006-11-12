Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753497AbWKLXdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbWKLXdA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 18:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbWKLXdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 18:33:00 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:58861 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1753497AbWKLXc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 18:32:59 -0500
Message-ID: <4557AF26.8030007@scientia.net>
Date: Mon, 13 Nov 2006 00:32:54 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: unexplainable read errors, copy/diff-issue
References: <4553DD90.1090604@scientia.net> <20061110135649.16cccca0.vsu@altlinux.ru>
In-Reply-To: <20061110135649.16cccca0.vsu@altlinux.ru>
Content-Type: multipart/mixed;
 boundary="------------020102020905070507060704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020102020905070507060704
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some additional notes:
1)
I just have had an PCI parity error (exactly on),.. but I don't think
that this is really an error or a damage.
It (the error) happens exactly when I activate PCI parity checking (echo
1 > /sys/devices/system/edac/pci/check_pci_parity).
(I've tested this several times, so this is fully reproducable.)
This is the message:
EDAC PCI: Bridge Detected Parity Error on 0000:00:09.0

lscpi says:
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)

Note that the following still applys: When doing the diffs and errors
occur,.. NO PCI parity error or memory errors are logged. And mcelog
still prints (really) nothing.

I should perhaps inform the authors of edac about that issue.


2)
I just tried the whole procedure from Knoppix 4.0 (which has a kernel
2.6.12).
It seems that it does not recognize most of my hardware (i.e. chipset
drivers for IDE and so on)...
So at first the diff runned for quite a time in non-DMA mode (which I
found out when I wondered why it took so long).
I then did a echo using_dma:1 > /proc/ide.../settings,... which
apperently worked,.. and nearly immediately after this,.. a difference
was found.
(But perhaps this was only by fortune). I aborted the test any do the
whole thing (with dma off) under my normal system.

Can anybody imagine that DMA could cause my problems? And if so,.. is it
likely that this would come from a hardware error or maybe from software?

Regards,
Chris.

--------------020102020905070507060704
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------020102020905070507060704--
