Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270524AbTHDIKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 04:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271357AbTHDIKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 04:10:39 -0400
Received: from mx0.gmx.de ([213.165.64.100]:40092 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id S270524AbTHDIKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 04:10:35 -0400
Date: Mon, 4 Aug 2003 10:10:34 +0200 (MEST)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [BUG] 2.6.0-t1 sis900 timeout
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [194.202.174.101]
Message-ID: <8723.1059984634@www20.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you check if the IRQ allocated to the SiS900 is the same on kernels
where it does work, and try without ACPI support, and/or any IO-APIC support
disabled?

I've seen this before with the network card in one of my systems - the
IO-APIC setup code, or ACPI table parsing was misprogramming the IRQ routing
tables, and it was being allocated the wrong level-triggered IRQ line.

Dan

-- 
Daniel J Blueman

COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post

