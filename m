Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132518AbRDDXBz>; Wed, 4 Apr 2001 19:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132519AbRDDXBp>; Wed, 4 Apr 2001 19:01:45 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:14077 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S132518AbRDDXBf>; Wed, 4 Apr 2001 19:01:35 -0400
Date: Wed, 04 Apr 2001 16:00:22 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: Contacts within AMD?  AMD-756 USB host-controller blacklisted due
 to
To: "Joachim 'roh' Steiger" <roh@convergence.de>,
        Miles Lane <miles@megapathdsl.net>
Cc: Thomas Dodd <ted@cypress.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Message-id: <052c01c0bd5b$0843ab60$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.21.0104050004060.21943-100000@campari.convergence.de>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Apr  4 14:47:15 campari kernel: usb-ohci.c: bogus NDP=204 for OHCI 
> usb-00:07.4
> Apr  4 14:47:15 campari kernel: usb-ohci.c: rereads as NDP=4

Means that your system would have oopsed if it hadn't
tested for the bogus register read (NDP).  That's only one
path; other bogus reads (which could also oops) on other
paths are undetected.  Slightly less-bogus reads on that
particular path may not be detected, and can still oops.

> please correct me if i'm wrong i only don't want to blacklist complete
> chipset-series

Then feel free to develop and submit a better fix.  That'd
be more practical if AMD's workaround were public.  As I
understand it, the bulk of the production chips have this
erratum.  More power to RedHat getting info from AMD.
Meanwhile, this patch improves robustness.

- Dave


