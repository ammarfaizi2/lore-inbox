Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbRLLRDY>; Wed, 12 Dec 2001 12:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281239AbRLLRDO>; Wed, 12 Dec 2001 12:03:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48910 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281214AbRLLRDB>; Wed, 12 Dec 2001 12:03:01 -0500
Subject: Re: VT82C686 && APM deadlock bug?
To: ast@domdv.de (Andreas Steinmetz)
Date: Wed, 12 Dec 2001 17:11:27 +0000 (GMT)
Cc: jdamery@chiark.greenend.org.uk (Jonathan D. Amery),
        linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20011212175053.ast@domdv.de> from "Andreas Steinmetz" at Dec 12, 2001 05:50:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ECul-0001kf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> going wrong during (apm?) screen blanking when there is interrupt activity.
> Unfortunately the system is frozen solid so there's no chance for any debug
> trace. It would be nice if someone with detail knowledge of the blanking code
> could have a look.

APM power management code is buried in the BIOS. We ask the APM bios nicely
to blank the display and power manage it. If the APM bios does something
daft we can't do much about it.

You can turn apm support off in your XFree86 config and see if that helps
