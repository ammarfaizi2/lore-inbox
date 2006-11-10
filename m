Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946055AbWKJIfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946055AbWKJIfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946057AbWKJIfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:35:45 -0500
Received: from mx1.suse.de ([195.135.220.2]:16091 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946055AbWKJIfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:35:44 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HZ: 300Hz support
References: <1163018557.23956.92.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 10 Nov 2006 09:35:17 +0100
In-Reply-To: <1163018557.23956.92.camel@localhost.localdomain>
Message-ID: <p73zmazitru.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Fix two things. Firstly the unit is "Hz" not "HZ". Secondly it is useful
> to have 300Hz support when doing multimedia work. 250 is fine for us in
> Europe but the US frame rate is 30fps (29.99 blah for pedants). 300
> gives us a tick divisible by both 25 and 30, and for interlace work 50
> and 60. It's also giving similar performance to 250Hz.
> 
> I'd argue we should remove 250 and add 300, but that might be excess
> disruption for now.

If we go down that path I would like to have 256.

Why? There are still lots of systems with broken Interrupt 0 routing
and usually on those the RTC works just fine. But unfortunately RTC
can be only programmed to power of two frequencies. 256 would fit.

-Andi
