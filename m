Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWHaDuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWHaDuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 23:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWHaDuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 23:50:20 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:46231 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1751051AbWHaDuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 23:50:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAAv59USBT4lZLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Conversion to generic boolean
Date: Wed, 30 Aug 2006 23:50:16 -0400
User-Agent: KMail/1.9.3
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <44EFBEFA.2010707@student.ltu.se> <44F3952B.5000500@yahoo.com.au> <Pine.LNX.4.61.0608290754550.952@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608290754550.952@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200608302350.17150.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 01:58, Jan Engelhardt wrote:
> 
> >> I was kinda planning on merging it ;)
> >> 
> >> I can't say that I'm in love with the patches, but they do improve the
> >> situation.
> >> 
> >> At present we have >50 different definitions of TRUE and gawd knows how
> >> many private implementations of various flavours of bool.
> >> 
> >> In that context, Richard's approach of giving the kernel a single
> >> implementation of bool/true/false and then converting things over to use
> >> it
> >> makes sense.  The other approach would be to go through and nuke the lot,
> >> convert them to open-coded 0/1.
> >
> > Well... we are programming in C here, aren't we ;)
> 
> I like it for the annotation we get.
> 
> 	int fluff;
> 	if(fluff == 0)
> 
> This does not tell if fluff is an integer or a boolean (that is, what the
> programmer intended to do -- not the 'int' the compiler sees).
> If it had been if(!fluff), it would give a hint, but a lot of places also have
> !x where x really is intended to be an integer (and should have been x==0 or
> y==NULL resp.)
>

Bool would not help much either unless declaration is immediately follows
use. I like Alan Sterns proposal ofencode return value in function name
better - actions should always return < 0/0 and predicates should always
be boolean equivalent.
 
-- 
Dmitry
