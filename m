Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUA2MZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 07:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265895AbUA2MZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 07:25:11 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:16091 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265871AbUA2MZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 07:25:04 -0500
Date: Thu, 29 Jan 2004 21:24:52 +0900
From: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
To: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Cc: willy@debian.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Message-id: <00ad01c3e662$e893ce10$2987110a@lsd.css.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com>
 <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
 <20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0401281129570.28145@home.osdl.org>
 <20040128204049.627e6312.ak@suse.de>
 <Pine.LNX.4.58.0401281205250.28145@home.osdl.org>
 <20040128211554.0cc890fb.ak@suse.de>
 <Pine.LNX.4.58.0401281221320.28145@home.osdl.org>
 <20040128220921.7ba0bb78.ak@suse.de>
 <Pine.LNX.4.58.0401281340301.28145@home.osdl.org>
 <20040128225205.02193769.ak@suse.de>
 <Pine.LNX.4.58.0401281420430.28145@home.osdl.org>
 <20040128233948.26a36ff7.ak@suse.de>
 <Pine.LNX.4.58.0401281458000.28145@home.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Linus Torvalds" <torvalds@osdl.org>
To: "Andi Kleen" <ak@suse.de>
Cc: <willy@debian.org>; <ishii.hironobu@jp.fujitsu.com>; <linux-kernel@vger.kernel.org>; <linux-ia64@vger.kernel.org>
Sent: Thursday, January 29, 2004 7:59 AM
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation


> 
> 
> On Wed, 28 Jan 2004, Andi Kleen wrote:
> > > Doing a status read from the device should do it (just read the config 
> > > space, for example).
> > 
> > The device is just not known. iirc you only get a bit in the bridge, which
> > leaves a wide choice.
> 
> read_pcix_error() _does_ know the device. The driver tells it.
> 
> Remember: none of this should be done at machine check time. 
> 
> Linus

Thank you for a lot of comments.
I prefer Linus's I/F than callback(exception) I/F,
because I can recover from intermittent errors.

I'd need time to consider how to map these I/F onto ia64 platform.
Later, I will post the result.

Thank you.
Hironobu Ishii

