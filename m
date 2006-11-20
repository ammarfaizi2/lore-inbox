Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756748AbWKTLRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748AbWKTLRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756724AbWKTLRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:17:38 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:27564 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1756748AbWKTLRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:17:37 -0500
Date: Mon, 20 Nov 2006 12:02:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Snook <csnook@redhat.com>
cc: Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, romieu@fr.zoreil.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] atl1: Header files for Attansic L1 driver
In-Reply-To: <456144C1.8040809@redhat.com>
Message-ID: <Pine.LNX.4.61.0611201200190.28860@yvahk01.tjqt.qr>
References: <20061119203006.GC29736@osprey.hogchain.net>
 <Pine.LNX.4.61.0611192233270.6324@yvahk01.tjqt.qr> <456144C1.8040809@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 20 2006 01:01, Chris Snook wrote:
> Jan Engelhardt wrote:
>> > +#define AT_READ_REG_ARRAY(a, reg, offset) ( \
>> > +	readl(((a)->hw_addr + reg) + ((offset) << 2)))
>> 
>> Possibly similarly.
>
> Yeah, we'll inline these as well.  Would you say that level of cosmetic
> cleanliness is required for merging, or should we focus solely on the
> functional issues for now?

Required? No I do not think so, there is worse code than this. (Don't
take that as an excuse to write bad code! :-)
It's just that it's easier to read if there are less parentheses.
These defines are a good example of border (define vs inline) cases.


	-`J'
-- 
