Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264650AbRFTWTR>; Wed, 20 Jun 2001 18:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbRFTWTH>; Wed, 20 Jun 2001 18:19:07 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:33490 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S264651AbRFTWTC>; Wed, 20 Jun 2001 18:19:02 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Victor Yodaiken" <yodaiken@fsmlabs.com>
Cc: "Larry McVoy" <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Why use threads ( was: Alan Cox quote?)
Date: Wed, 20 Jun 2001 15:18:58 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKOENMPPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
In-Reply-To: <20010620152604.B32617@hq2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Jun 20, 2001 at 02:01:16PM -0700, David Schwartz wrote:

> > 	It's very hard to use processes for this purpose. Consider,
> > for example, a
> > web server. You don't want to use one process for each client
> > because that
> > would limit your scalability (16,000 clients would become difficult, and
> > with threads it's trivial). You don't want to use one thread
> > for each client

> How is it trivial? How do you debug a 16,000 thread application?

	As I said, you don't want to use one thread for each client. You use, say,
10 threads for the 16,000 clients. That way, if an occasional client
ambushes a thread (say by reading a file off an NFS server or by using some
infrequently used code that was swapped to a busy disk), your server will
keep on humming.

	DS


