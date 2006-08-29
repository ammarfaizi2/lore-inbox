Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWH2GEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWH2GEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 02:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWH2GEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 02:04:40 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:9391 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751208AbWH2GEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 02:04:39 -0400
Date: Tue, 29 Aug 2006 07:58:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
In-Reply-To: <44F3952B.5000500@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0608290754550.952@yvahk01.tjqt.qr>
References: <44EFBEFA.2010707@student.ltu.se> <20060828093202.GC8980@infradead.org>
 <20060828171804.09c01846.akpm@osdl.org> <44F3952B.5000500@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I was kinda planning on merging it ;)
>> 
>> I can't say that I'm in love with the patches, but they do improve the
>> situation.
>> 
>> At present we have >50 different definitions of TRUE and gawd knows how
>> many private implementations of various flavours of bool.
>> 
>> In that context, Richard's approach of giving the kernel a single
>> implementation of bool/true/false and then converting things over to use
>> it
>> makes sense.  The other approach would be to go through and nuke the lot,
>> convert them to open-coded 0/1.
>
> Well... we are programming in C here, aren't we ;)

I like it for the annotation we get.

	int fluff;
	if(fluff == 0)

This does not tell if fluff is an integer or a boolean (that is, what the
programmer intended to do -- not the 'int' the compiler sees).
If it had been if(!fluff), it would give a hint, but a lot of places also have
!x where x really is intended to be an integer (and should have been x==0 or
y==NULL resp.)


Jan Engelhardt
-- 
