Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbUK2QmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbUK2QmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbUK2QmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:42:08 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:39419 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261757AbUK2Qlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:41:51 -0500
In-Reply-To: <Pine.LNX.4.61.0411291602330.18143@hibernia.jakma.org>
Subject: Re: [patch 4/10] s390: network driver.
To: Paul Jakma <paul@clubi.ie>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF7E76C3BE.B1D182D3-ONC1256F5B.005B3E84-C1256F5B.005BB584@de.ibm.com>
From: Thomas Spatzier <thomas.spatzier@de.ibm.com>
Date: Mon, 29 Nov 2004 17:41:42 +0100
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 29/11/2004 17:41:54
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Paul Jakma <paul@clubi.ie> wrote on 29.11.2004 17:30:23:
> Well, if the kernel is going to queue these packets without notifying
> us, we absolutely *must* have some way to flush those queues. Sending
> stale packets many minutes after the application generated them could
> have serious consequences for routing (eg, think sending RIP, IPv4
> IRDP or v6 RAs which are no longer valid - client receives them and
> installs routes which are long invalid and loses connectivity to some
> part of the network).
>

Yes, for the examples you mentioned the app should better be notified.
However, AFAICS, there are no such notification mechanisms on a
per-packet basis implemented in the kernel.
And I doubt that they are going to be implemented.

> I'd be very interested to hear advice from the kernel gurus (eg "god,
> dont be so stupid, do xyz in your application instead"). We can
> accomodate whatever kernel wants as long as its workable.

Good suggestion, if anyone has an interesting and feasible solution
I will be happy to integrate it. So far, however, it don't see one and I
would point people being worried about lost packets to TCP.


Regards,
Thomas.

