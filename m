Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267321AbUBSVXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267256AbUBSVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:22:35 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:5335 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S267348AbUBSVWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:22:10 -0500
From: oschoett@t-online.de (Oliver Schoett)
To: linux-kernel@vger.kernel.org
Subject: Recommendation: [PATCH] SIS AGP 648[FX] cleaned+fixed ...
References: <1obEA-82t-11@gated-at.bofh.it>
Date: 19 Feb 2004 22:22:02 +0100
In-Reply-To: <1obEA-82t-11@gated-at.bofh.it>
Message-ID: <s23oerukbnp.fsf@oschoett.dialin.t-online.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Seen: false
X-ID: bKlDy2ZBoeguJ7B69M0VMklrlkZ24wA+Fx+umadg16Gs8veCT-89QR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Heilmann, Oliver" <Oliver.Heilmann@drkw.com> writes:

 > This patch is provides AGP support for sis 648 and 648FX chipsets
 > (previous versions only worked on FX chipsets).

I would like to point out how important this patch is.  My Motherboard
(Microstar MS-6701, branded MD-5000) has a SIS 648 north bridge, and
for months before the patch, I have observed the following: on a
freshly booted system, after

   insmod agpgart
   insmod sis-agp
   insmod fglrx            (the binary kernel module from ATI)
   /etc/init.d/xdm start   (start X server)

the machine would always lock up completely: black screen, no IDE disk
I/O, no Ctrl-Alt-Backsp or Ctrl-Alt-F1, only the SysRq keys worked.  I
have actually lost data due to the blocked disk I/O when experimenting
with this.  The problem has been consistent for the entire 2.6.0-test*
and 2.6.* kernel series and for various versions of the binary ATI
drivers for my ATI 9600TX graphics card.

The patch by Oliver Heilmann makes the above process work flawlessly
on my machine on kernels 2.6.2 and 2.6.3, and with variations such als
letting sis-agp pull in agpgart and letting the X server pull in the
fglrx module.

(Actually, for my SIS 648 chip, just the 10ms timeout is enough, but I
have read reports on the gentoo board by SIS 648FX owners that the
patch turned their graphics cards from not working to working with DRI
for the first time.)

This patch is an important contribution for owners of the common SIS
648 and SIS 648FX north bridge chips, and I therefore recommend it for
inclusion in the kernel AGP driver.

Regards,

Oliver Schoett

