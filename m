Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269853AbRHNTCn>; Tue, 14 Aug 2001 15:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270794AbRHNTCg>; Tue, 14 Aug 2001 15:02:36 -0400
Received: from [209.202.108.240] ([209.202.108.240]:2835 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S270076AbRHNTBo>; Tue, 14 Aug 2001 15:01:44 -0400
Date: Tue, 14 Aug 2001 15:01:24 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: memory compress tech...
In-Reply-To: <Pine.GSO.4.31.0108140924260.3860-100000@cardinal0.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0108141242160.31226-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Ted Unangst wrote:

> maybe for compressing swap?  you have to read less data off the disk,
> which is faster.  and the processor is probably idling anyway, waiting on
> disk.

Ah, now THAT is a good idea.

Compressing groups of pages, probably 16k at a time, and storing them on 20k
boundaries will result in a loss of swap space but a probable increase in
speed. And the boundary alignment will probably simplify bookkeeping. You
shouldn't be using swap anyways, so a 20% loss probably isn't a huge deal.

Maybe someone with a little more experience in the area of swap management
under Linux should take over the discussion from here...

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>





