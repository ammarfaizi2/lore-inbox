Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131207AbRC0QE3>; Tue, 27 Mar 2001 11:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131233AbRC0QEU>; Tue, 27 Mar 2001 11:04:20 -0500
Received: from cable039.201.eneco.bart.nl ([195.38.201.39]:56325 "EHLO
	procyon.wilson.nl") by vger.kernel.org with ESMTP
	id <S131207AbRC0QEM>; Tue, 27 Mar 2001 11:04:12 -0500
From: "Michel Wilson" <michel@procyon14.yi.org>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] OOM handling
Date: Tue, 27 Mar 2001 18:03:23 +0200
Message-ID: <NEBBLEJBILPLHPBNEEHIKECICBAA.michel@procyon14.yi.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <l03130337b6e65e809070@[192.168.239.101]>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> relative ages.  The major flaw in my code is that a sufficiently
> long-lived
> process becomes virtually immortal, even if it happens to spring a serious
> leak after this time - the flaw in yours is that system processes

I think this could easily be fixed if you'd 'chop off' the runtime at a
certain point:

if(runtime > something_big)
	runtime = something_big;

This would of course need some tuning. The only thing i don't like about
this is that it's a kind of 'magical value', but i suppose it's not a very
good idea to make this configurable, right?

Michel Wilson.

