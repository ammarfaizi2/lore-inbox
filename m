Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWGWVea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWGWVea (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWGWVea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 17:34:30 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:8894 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750708AbWGWVe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 17:34:29 -0400
Date: Sun, 23 Jul 2006 23:17:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Garzik <jeff@garzik.org>
cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
In-Reply-To: <44C3DB28.2090003@garzik.org>
Message-ID: <Pine.LNX.4.61.0607232316420.1638@yvahk01.tjqt.qr>
References: <1153341500.44be983ca1407@portal.student.luth.se>
 <1153669750.44c39a7607a30@portal.student.luth.se>
 <Pine.LNX.4.61.0607231805210.26413@yvahk01.tjqt.qr> <44C3DB28.2090003@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > +#define false false
>> > +#define true true 
>> 
>> Can someone please tell me what advantage 'define true true' is going to
>> bring, besides than being able to '#ifdef true'?
>
> It
>
> (a) makes type information available to the C compiler, where a plain #define
> does not.

Do you mean preprocessor? C already knows about true from the enum.

> (b) handles all '#ifndef true' statements properly

Holy *, is there _really_ code in linux/ that depends on true being 
[not] defined?


Jan Engelhardt
-- 
