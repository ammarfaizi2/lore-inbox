Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277371AbRKHSIP>; Thu, 8 Nov 2001 13:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277533AbRKHSIJ>; Thu, 8 Nov 2001 13:08:09 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:16394
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S277371AbRKHSHO>; Thu, 8 Nov 2001 13:07:14 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200111081744.fA8Hivr07577@www.hockin.org>
Subject: Re: WOL stops working on halt
To: akpm@zip.com.au (Andrew Morton)
Date: Thu, 8 Nov 2001 09:44:57 -0800 (PST)
Cc: madmatt@bits.bris.ac.uk (Matt), linux-kernel@vger.kernel.org
In-Reply-To: <3BEAC5E2.5A301DB@zip.com.au> from "Andrew Morton" at Nov 08, 2001 09:50:26 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as the driver is concerned, a shutdown and a reboot are identical,
> so we need to look at external causes.  Presumably Linux APM or BIOS.

With our boards I had to track the issue that the chipset only delivered 
wake events in certain sleep modes.  It could be that linux shutdown puts
the system in a sleep mode that does not accept wake-events, but the
power-button override puts it in a wake-able sleep.  (S5 vs S3/4 ?).  Our
solution is to enable wake events in S3/4/5 on the chipset.

It could be not a net driver issue but an ACPI issue.

Tim
