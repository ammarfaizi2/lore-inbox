Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757240AbWKWAlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240AbWKWAlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 19:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757241AbWKWAlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 19:41:15 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:26451 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932313AbWKWAlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 19:41:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=yp4PAkNfC0hBbIpj4R8HOufapyKsqjwFRFpb+HcLvZbFhOGnyWrn7NSHAcQHzVWt8f4HQCroR1V5QNe11fhtAlnoKMJGZIuJknLIHqWiPNvr/DTwnvbIUJYj6gFTO/pBhv3L9HihgiImAQrYo5wt9rdk8YN/EV5G+FtPpLZbXgY=  ;
X-YMail-OSG: 2U5HT2EVM1masmIDgLS1UWbGg.0CxIbl8W1KirteIdGqKCRlGdczPol2vqVV7DyvEdclwBPms3DYK9TBNoXuFbUIkJ7jjFzMxOzKWqZlQduwmdH_jlzVyw--
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.19-rc6 6/6] rtc-omap driver
Date: Wed, 22 Nov 2006 16:09:49 -0800
User-Agent: KMail/1.7.1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tony Lindgren <tony@atomide.com>
References: <200611201014.41980.david-b@pacbell.net> <200611211815.43929.david-b@pacbell.net> <20061121182828.4fc32802.akpm@osdl.org>
In-Reply-To: <20061121182828.4fc32802.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221609.50327.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 6:28 pm, Andrew Morton wrote:

> > Starting in 2037 or whenever, various things will be breaking...
> > 
> > Probably the RTC lib routines should use a time_t, and when that gets
> > changed to 64 bits then things like this will be fixed automagically.
> > Right now they use "unsigned long".
> > 
> > I suggest Alessandro handle those issues.
> 
> We could simply (ab)use timer_after() here.

We could indeed.  But things will still break badly in 2037,
and the timer_after() thing is clearly an incomplete fix.

- Dave
