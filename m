Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423831AbWKHWjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423831AbWKHWjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423832AbWKHWjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:39:42 -0500
Received: from 1wt.eu ([62.212.114.60]:5125 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1423831AbWKHWjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:39:41 -0500
Date: Wed, 8 Nov 2006 23:39:24 +0100
From: Willy Tarreau <w@1wt.eu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] HZ: 300Hz support
Message-ID: <20061108223924.GA589@1wt.eu>
References: <1163018557.23956.92.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163018557.23956.92.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 08:42:37PM +0000, Alan Cox wrote:
> Fix two things. Firstly the unit is "Hz" not "HZ". Secondly it is useful
> to have 300Hz support when doing multimedia work. 250 is fine for us in
> Europe but the US frame rate is 30fps (29.99 blah for pedants). 300
> gives us a tick divisible by both 25 and 30, and for interlace work 50
> and 60. It's also giving similar performance to 250Hz.
> 
> I'd argue we should remove 250 and add 300, but that might be excess
> disruption for now.

I'd like to keep 250 for a simple reason : the period is an integer
number of milliseconds. I find it very convenient to be able to convert
jiffies to ms. It serves at several places, for instance, poll(). In
fact, what I like with 250 is that there is no divide between ms and
jiffies, but just a bit shift.

Regards,
Willy

