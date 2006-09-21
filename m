Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWIUCvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWIUCvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 22:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWIUCvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 22:51:08 -0400
Received: from web36707.mail.mud.yahoo.com ([209.191.85.41]:26749 "HELO
	web36707.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751026AbWIUCvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 22:51:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oIBgbrVy2K92yRmosKkqPXY4oqmDgFuL2h52z9jbKnYxCvb+hhtZ8GCwLk3WBEnO4q6+H005Z9Ky5mP/NGbxpyt2qbC19/zwHL44IYi4kOovGoohLg3H7Z/kSNKZZTJGaqhIGytC44F6NYhKBQFUE16xCYtBEwxyXEZhC2nrB7o=  ;
Message-ID: <20060921025106.61978.qmail@web36707.mail.mud.yahoo.com>
Date: Wed, 20 Sep 2006 19:51:06 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [PATCH 1/2] [MMC] Driver for TI FlashMedia card reader - source
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, drzeus-list@drzeus.cx,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20060919232016.68a02e0e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could I ask where the information which permitted this (nice-looking) driver to
> be written came from?

I had 3 sources for this:
1. win64 binary driver
2. linux binary driver - it says its license is GPL, but source is nowhere to be found
3. OMAP 5912 datasheet for part of the tifm_sd functionality

My upcoming memorystick driver only draws from the first two sources. I should also add that I
never worked for TI nor Everest Consulting (the authors of the binary driver) and don't know
anybody who ever did.

> The driver has lots of really big inlined functions.  It's best to uninline
> these.  If the function has a single callsite, gcc will inline it anyway. 
> If the function has multiple callsites (now, or in the future), inlining it
> is undesirable.

I actually marked them "inline" to signify the fact that only one callsite is intended for these
functions. They are not intended to be called from arbitrary places (no problem to fix those,
though).



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
