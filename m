Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTINKpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 06:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTINKpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 06:45:49 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:38844 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S262228AbTINKps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 06:45:48 -0400
Message-ID: <1f4a01c37aad$5179bf10$2dee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <1b7401c37a73$87b0e250$2dee4ca5@DIAMONDLX60> <20030914091922.C20889@flint.arm.linux.org.uk>
Subject: Re: 2.6.0-test5 vs. modem cards
Date: Sun, 14 Sep 2003 19:44:33 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Russell King" <rmk@arm.linux.org.uk> replied to me:

> > In file 8250_cs.c:
>
> Its going to get renamed back to serial_cs shortly.

OK.

> > Later in the same source file, calls to register_serial() and
> > unregister_serial() compile but fail during execution.  Of course in order
> > to make it execute in the first place I have to manually modprobe 8250_cs,
> > because of the reason mentioned above.  /var/log/messages gets reports that
> > those symbols are unknown.
>
> I have no idea how you managed that.  The configuration subsystem does
> not allow you to build 8250_cs.c as a module without building 8250.c in
> some manner, and 8250.c provides those symbols.

I built 8250.c as a module, but might have neglected to modprobe it.  Since
a manual modprobe of 8250_cs also neglected to automatically modprobe its
dependency 8250, there might be breakage in modprobe, or this might just be
additional breakage in the naming of 8250 vs. serial.

