Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264555AbTFAMex (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 08:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbTFAMew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 08:34:52 -0400
Received: from tag.witbe.net ([81.88.96.48]:12304 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264555AbTFAMew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 08:34:52 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Ruud Linders'" <rkmp@xs4all.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Serial port numbering (ttyS..) wrong for 2.5.61+
Date: Sun, 1 Jun 2003 14:48:14 +0200
Message-ID: <015a01c3283c$11642370$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <3ED9E025.1060801@xs4all.nl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Since I tried the 2.5 kernel versions somewhere in the 2.5.6x range, I
> see rather odd port naming for the extra 4 serial ports on a PCI-card.
Which driver are you using ?

> The first two are numered as ttyS14, ttyS15 while the last two are
> ttyS2 and ttyS3 !
> I tried to find where these numbers are coming from but 
> couldn't really
> find an obvious place in the various drivers/char/* or 
> drivers/serial/*
> files.

Numbering seems to be coming out of 
drivers/serial/core.c : uart_find_match_or_unused
which is responsible for finding an unused state for the port.

However, the code there seems to be clean and I guess we should look
where the state are initialized.

Paul

