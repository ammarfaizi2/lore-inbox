Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUC1U1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUC1U1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:27:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21472 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262453AbUC1U0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:26:10 -0500
Message-ID: <406734D3.7070501@pobox.com>
Date: Sun, 28 Mar 2004 15:25:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <40667FAB.2090802@stesmi.com>
In-Reply-To: <40667FAB.2090802@stesmi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:
> Hi Jeff.
> 
>> I'm about to add a raft of SATA-2 hardware, all of which are queued. 
>> The standard depth is 32, but one board supports a whopping depth of 256.
> 
> 
> Speaking of which .. I just read an announcement that someone (of course
> the name eludes me) announced a DVD Burner that's SATA.
> 
> Found it:
> 
> http://www.plextor.com/english/news/press/712SA_pr.htm
> 
> a) Are there provisions in the SATA (1) SPEC for support of
> non-disk units?
> 
> b) if (strcmp(a, "no"))
>      Do you know anything about it, ie is it SATA1 or 2 or what?
> 
> c) Let's ponder one gets a unit like this - is it usable with
> libata yet?
> 
> d) if (strcmp(c, "no"))
>      Will it? :)


SATA ATAPI looks and works just like PATA ATAPI, with one notable 
exception:  S/ATAPI will include "asynchronous notification", a feature 
that allows you to eliminate the polling of the cdrom driver that 
normally occurs.

You can use ATAPI on SATA today, using a PATA->SATA bridge.  In fact 
that's the only way I can test SATA ATAPI at all, right now.

I hope somebody sends me one of these Plextor devices for testing ;-)

	Jeff



