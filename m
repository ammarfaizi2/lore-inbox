Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTFJHFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 03:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTFJHFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 03:05:05 -0400
Received: from netmail01.services.quay.plus.net ([212.159.14.219]:47271 "HELO
	netmail01.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262400AbTFJHFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 03:05:01 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "george anzinger" <george@mvista.com>, "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>, "Eric Piel" <Eric.Piel@Bull.Net>
Subject: RE: [PATCH] More time clean up stuff.
Date: Tue, 10 Jun 2003 09:18:53 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAEEEGEEAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <3EE52CFA.6070607@mvista.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George.

I'm ignoring the rest of this - it makes sense to me, but I'm
no expert in it. However, your last point is one I can comment
about as I've dealt with it professionally many times.

 > clock_nanosleep is changed to round up to the next jiffie to
 > cover starting between jiffies.

Isn't this a case of replacing one error with another, where
one of the two errors is unavoidable?

 1. In the old case, the sleep will on average be half a jiffie
    LESS than the requested period.

 2. In the new case, the sleep will on average be half a jiffie
    MORE than the requested period.

One or the other is unavoidable if a jiffie is the basic unit
of time resolution of the system. However, the error is totally
meaningless if we are asking to sleep for more than 15 jiffies.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.488 / Virus Database: 287 - Release Date: 5-Jun-2003

