Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbVF3Q4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbVF3Q4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbVF3Q4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:56:30 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:21396 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S263012AbVF3Q4G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:56:06 -0400
X-IronPort-AV: i="3.94,154,1118034000"; 
   d="scan'208"; a="260697037:sNHT23638808"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
Date: Thu, 30 Jun 2005 11:56:02 -0500
Message-ID: <B1939BC11A23AE47A0DBE89A37CB26B407434B@ausx3mps305.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcV9jvboLnykyAOORAS/GMIhlJZYBQABJtZg
From: <Stuart_Hayes@Dell.com>
To: <ak@suse.de>
Cc: <riel@redhat.com>, <andrea@suse.dk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Jun 2005 16:56:03.0821 (UTC) FILETIME=[99C259D0:01C57D94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> I only fixed it for x86-64 correct. Does it work for you on x86-64?
> 
> If yes then the changes could be brought over.
> 
> What do you all need this for anyways?
> 
> -Andi

We need this because the NVidia driver uses change_page_attr() to make
pages non-cachable, which is causing systems to spontaneously reboot
when it gets a page that's in the first 8MB of memory.

I'll look at x86_64.  The problem was seen originally with i386, and I
haven't taken much time to look at the x86_64 stuff yet.

Thanks,
Stuart

