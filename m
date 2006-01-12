Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWALEco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWALEco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWALEco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:32:44 -0500
Received: from mx.pathscale.com ([64.160.42.68]:39659 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S965013AbWALEco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:32:44 -0500
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org
In-Reply-To: <200601120519.12960.ak@suse.de>
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com>
	 <200601120233.51601.ak@suse.de>
	 <1137039242.29795.5.camel@camp4.serpentine.com>
	 <200601120519.12960.ak@suse.de>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 20:32:40 -0800
Message-Id: <1137040361.29795.8.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 05:19 +0100, Andi Kleen wrote:

> My feeling is more and more that this thing is so specialized for your setup
> and so narrow purpose that you're best off dropping this whole patchkit and 
> just put the assembly into your driver.

But this gave people fits when Roland first posted the driver for
review.  There's also no clean, obvious way to make it work on other
64-bit architectures, in that case.

I don't mind switching the movsq to a movsd, if that's the main aspect
of what you're worried about now, so that it is absolutely a 32-bit
copy.

	<b



