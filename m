Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317403AbSFRNEF>; Tue, 18 Jun 2002 09:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317401AbSFRNEF>; Tue, 18 Jun 2002 09:04:05 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:15559 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S317400AbSFRNEE>; Tue, 18 Jun 2002 09:04:04 -0400
Message-ID: <008001c216c8$d0bfdba0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <rwhite@pobox.com>, "Ed Vance" <EdV@macrolink.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'Theodore Tso'" <tytso@mit.edu>
References: <11E89240C407D311958800A0C9ACF7D13A7881@EXCHANGE> <200206171900.03955.rwhite@pobox.com>
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a ll recent versions)
Date: Tue, 18 Jun 2002 09:05:20 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Robert White" <rwhite@pobox.com>
> should you use your greater-access to the code and user base, you would
find
> a single case where it breaks, invalidates, or confuses a single person or
> program on the planet.

I can see one easy case: protocol has frame size of N. VMIN is set to
say 3 * N. read() supplies a buffer of N. The purpose being that the
first read will block until 3 frames are ready to process, then return
the first one. Your patch would break that.

Having said that, I don't know of any instances where the above is
employed. I'd say your patch is worthwhile.

..Stu


