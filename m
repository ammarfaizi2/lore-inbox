Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbRGYTAA>; Wed, 25 Jul 2001 15:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268613AbRGYS7v>; Wed, 25 Jul 2001 14:59:51 -0400
Received: from barney.blueskylabs.com ([64.0.135.181]:29797 "EHLO
	barney.intra.blueskylabs.com") by vger.kernel.org with ESMTP
	id <S267215AbRGYS7a> convert rfc822-to-8bit; Wed, 25 Jul 2001 14:59:30 -0400
Subject: RE: user-mode port 0.44-2.4.7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
content-class: urn:content-classes:message
Date: Wed, 25 Jul 2001 12:03:48 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <32B25F556FCD9D418D73C742C9B2E36D096795@barney.intra.blueskylabs.com>
Thread-Topic: RE: user-mode port 0.44-2.4.7
Thread-Index: AcEVPIj7FROOn4eFRz+mkOnIC1AIKw==
From: "James W. Lake" <jim@intra.blueskylabs.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


What about a case when you have a struct
struct queue
{
	int head;
	int tail;
	...
} myqueue;
You update head in an isr and tail in one singular open fop_read() call.
Either don't mind getting old values of the one they don't update, want
to get the latest version of the variable as often as possible.
Should head and tail be volatile in the definition, or should they be
accessed with:
int head = (volatile)myqueue.head;
or with barrier() around the read/write?
Jim Lake

