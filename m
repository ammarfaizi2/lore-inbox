Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265370AbUF2Cu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUF2Cu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 22:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUF2Cu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 22:50:26 -0400
Received: from mail.inter-page.com ([12.5.23.93]:31748 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S265370AbUF2CuY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 22:50:24 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: <oliver@neukum.org>, <scott@timesys.com>, <zaitcev@redhat.com>,
       <greg@kroah.com>, <arjanv@redhat.com>, <jgarzik@redhat.com>,
       <tburke@redhat.com>, <linux-kernel@vger.kernel.org>,
       <stern@rowland.harvard.edu>, <mdharm-usb@one-eyed-alien.net>,
       <david-b@pacbell.net>
Subject: RE: drivers/block/ub.c
Date: Mon, 28 Jun 2004 19:49:51 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAAxSTKwqq2EuUht/ftlgbZAEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20040628191545.7a298bc3.davem@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, that is what it does.  That is not what *I* would have *expected* it to do.  I
would have expected it to remain a struct when viewed from the outside rather than
become an "N-byte blob".


-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com] 
Sent: Monday, June 28, 2004 7:16 PM
To: Robert White
Cc: oliver@neukum.org; scott@timesys.com; zaitcev@redhat.com; greg@kroah.com;
arjanv@redhat.com; jgarzik@redhat.com; tburke@redhat.com;
linux-kernel@vger.kernel.org; stern@rowland.harvard.edu;
mdharm-usb@one-eyed-alien.net; david-b@pacbell.net
Subject: Re: drivers/block/ub.c

On Mon, 28 Jun 2004 18:54:46 -0700
"Robert White" <rwhite@casabyte.com> wrote:

> The below makes no sense to me...  Nothing in the definition of struct bar{} (which
> is not packed) infers (top me) in the slightest that foo should be unnaturally
> aligned within it.

First of all, it is what the compiler does and has done since the
__packed__ attribute was added.

Second of all, you are asking it to "PACK" the structure, this includes
any place you place it within other data objects.  It becomes an N-byte
blob that has no alignment constraints must be placed exactly where it
is declared.

I am growing very tired of this thread.


