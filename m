Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWAQIRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWAQIRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 03:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWAQIRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 03:17:21 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:25685 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932312AbWAQIRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 03:17:20 -0500
Message-ID: <43CCA80B.4020603@tls.msk.ru>
Date: Tue, 17 Jan 2006 11:17:15 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: NeilBrown <neilb@suse.de>
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
References: <20060117174531.27739.patches@notabene>
In-Reply-To: <20060117174531.27739.patches@notabene>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown wrote:
> Greetings.
> 
> In line with the principle of "release early", following are 5 patches
> against md in 2.6.latest which implement reshaping of a raid5 array.
> By this I mean adding 1 or more drives to the array and then re-laying
> out all of the data.

Neil, is this online resizing/reshaping really needed?  I understand
all those words means alot for marketing persons - zero downtime,
online resizing etc, but it is much safer and easier to do that stuff
'offline', on an inactive array, like raidreconf does - safer, easier,
faster, and one have more possibilities for more complex changes.  It
isn't like you want to add/remove drives to/from your arrays every day...
Alot of good hw raid cards are unable to perform such reshaping too.

/mjt
