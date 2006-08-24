Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWHXOns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWHXOns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWHXOns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:43:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5137 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S932121AbWHXOnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:43:47 -0400
Date: Thu, 24 Aug 2006 14:43:29 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Indan Zupancic <indan@nul.nu>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH 4/4] deadlock prevention for NBD
Message-ID: <20060824144329.GA4092@ucw.cz>
References: <20060812141415.30842.78695.sendpatchset@lappy> <20060812141455.30842.41506.sendpatchset@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060812141455.30842.41506.sendpatchset@lappy>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Limit each request to 1 page, so that the request throttling also limits the
> number of in-flight pages and force the IO scheduler to NOOP as anything else
> doesn't make sense anyway.

I'd like to understand why it breaks with other schedulers before
merging this. Maybe the failure in NOOP is just harder to trigger?

							Pavel

-- 
Thanks for all the (sleeping) penguins.
