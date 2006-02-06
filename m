Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWBFBh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWBFBh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 20:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWBFBh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 20:37:27 -0500
Received: from web33005.mail.mud.yahoo.com ([68.142.206.69]:49333 "HELO
	web33005.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750755AbWBFBh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 20:37:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qFcIMpfJvBLv/CBtUvL+KC7u4MgQovW4A0bQfne9ceTc1arPoTy2zTjuwOMZxQJZlCagTa1+cfQyp1ucsv4EMRn37966EdyjefXLmrBkE76pWCo4Yz6zwpPCMllgTlwuxxazht9srwcRlYHUulZGmfehjXpwXpOVBsC1/s7XIFM=  ;
Message-ID: <20060206013726.58296.qmail@web33005.mail.mud.yahoo.com>
Date: Sun, 5 Feb 2006 17:37:26 -0800 (PST)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: [VM PATCH] rotate_reclaimable_page fails frequently
To: Mika =?ISO-8859-1?Q?=20=22Penttil=E4=22?= 
	<mika.penttila@kolumbus.fi>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <43E630AB.6060006@kolumbus.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Mika Penttilä <mika.penttila@kolumbus.fi> wrote:
>  I think this BUGs easily because shrink_cache
> doesn't expect to see 
> unfreeable pages put back to LRU.

Not quite.  In shrink_list(), we never return pages
that were put back on the LRU by omitting their
addition to `ret_pages'.  shrink_cache() only releases
pages on this list.

Shantanu


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
