Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWA3RZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWA3RZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWA3RZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:25:36 -0500
Received: from bay108-dav12.bay108.hotmail.com ([65.54.162.84]:21235 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S964830AbWA3RZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:25:35 -0500
Message-ID: <BAY108-DAV12766C7B1A084C00C833FE93090@phx.gbl>
X-Originating-IP: [143.182.124.2]
X-Originating-Email: [multisyncfe991@hotmail.com]
From: "John Smith" <multisyncfe991@hotmail.com>
To: <netdev@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
References: <20060124225919.GC12566@suse.de> <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de> <4807377b0601251137r7621216byc47b03a3c634557c@mail.gmail.com> <4807377b0601251628k4227dad0ld731f2c25c211b91@mail.gmail.com> <BAY108-DAV111F6EF46F6682FEECCC1593140@phx.gbl> <4807377b0601271404w6dbfcff6s4de1c3f785dded9f@mail.gmail.com>
Subject: Can I do a regular read to simulate prefetch instruction?
Date: Mon, 30 Jan 2006 10:25:34 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 30 Jan 2006 17:25:35.0228 (UTC) FILETIME=[2E001BC0:01C625C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I find out some network card drivers (e.g. e1000 driver) use prefetch 
instruction
to reduce memory access latency and speed up data operation. My question is:
Support we want to pre-read a skb buffer into the cache, what is the 
difference
between the following two methods, i.e. what is the different when using 
prefetch
and using a regular read opertation?
1. use prefetch instruction to stimulate a pre-fetch of the skb address,
    e.g. prefetch(skb);
2. use an assignment statement to stimulate a pre-fetch of the skb address,
    e.g. skb1 = skb;

I was told the data will be prefetched into a so-called prefetching queue 
only by
using prefetching instruction? Is this true?

Thanks,

John


