Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265307AbRF0Ixl>; Wed, 27 Jun 2001 04:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265308AbRF0Ixb>; Wed, 27 Jun 2001 04:53:31 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:37066 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S265307AbRF0IxU>; Wed, 27 Jun 2001 04:53:20 -0400
Message-ID: <3B399EF8.9BA76FA2@TeraPort.de>
Date: Wed, 27 Jun 2001 10:53:12 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> * If we're getting low cache hit rates, don't flush 
>> processes to swap. 
>> * If we're getting good cache hit rates, flush old, idle 
>> processes to swap. 

Rik> ... but I fail to see this one. If we get a low cache hit rate, 
Rik> couldn't that just mean we allocated too little memory for the 
Rik> cache ? 

 maybe more specific: If the hit-rate is low and the cache is already
70+% of the systems memory, the chances maybe slim that more cache is
going to improve the hit-rate. 

 I do not care much whether the cache is using 99% of the systems memory
or 50%. As long as there is free memory, using it for cache is great. I
care a lot if the cache takes down interactivity, because it pushes out
processes that it thinks idle, but that I need in 5 seconds. The caches
pressure against processes should decrease with the (relative) size of
the cache. Especially in low hit-rate situations.

 OT: I asked the question before somewhere else. Are there interfaces to
the VM that expose the various cache sizes and, more important,
hit-rates to userland? I would love to see (or maybe help writing in my
free time) a tool to just visualize/analyze the efficiency of the VM
system.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
