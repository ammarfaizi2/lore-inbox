Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbTJMFFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 01:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTJMFFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 01:05:39 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:21753 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S261429AbTJMFFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 01:05:36 -0400
Message-ID: <316f01c39147$8f4a1b90$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test7 with recent modutils vs. module symbols
Date: Mon, 13 Oct 2003 14:03:59 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a Red Hat 7.3 system with old modutils, I installed modutils-2.4.21-18
from an RPM.  The new modutils work fine under kernels 2.6.0-test1 through
test7 as well as kernel 2.4.18.

On a SuSE 8.1 system with old modutils, I had trouble installing the new
modutils from an RPM, and then had trouble building it by hand.  The result
could do modprobe and rmmod and lsmod, but a boot time error said that
module symbols were unavailable because modules weren't enabled.  Booting
kernel 2.4.19 yielded no such error.

On a SuSE 8.2 system with modutils-2.4.22-33, fortunately something stopped
me just in time from downgrading to modutils-2.4.21-18.  The distro's
modutils-2.4.22-33 can do modprobe and rmmod and lsmod, but the same boot
time error says that module symbols are unavailable because modules aren't
enabled.  Booting kernel 2.4.20 yields no such error.

What is it about the combination of 2.6.0-test[1-7] and SuSE that has this
error, while other combinations do not?

Here is part of /var/log/messages:

Oct 12 21:09:23 diamondpana kernel: Inspecting /boot/System.map-2.6.0-test7
Oct 12 21:09:25 diamondpana kernel: Loaded 25702 symbols from
   /boot/System.map-2.6.0-test7.
Oct 12 21:09:25 diamondpana kernel: Symbols match kernel version 2.6.0.
Oct 12 21:09:25 diamondpana kernel: No module symbols loaded - kernel
   modules not enabled.
