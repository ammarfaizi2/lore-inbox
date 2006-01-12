Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWALEq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWALEq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWALEq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:46:56 -0500
Received: from ns2.suse.de ([195.135.220.15]:59577 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965029AbWALEq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:46:56 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
Date: Thu, 12 Jan 2006 05:45:34 +0100
User-Agent: KMail/1.8
Cc: akpm@osdl.org, rdreier@cisco.com, linux-kernel@vger.kernel.org
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com> <200601120519.12960.ak@suse.de> <1137040361.29795.8.camel@camp4.serpentine.com>
In-Reply-To: <1137040361.29795.8.camel@camp4.serpentine.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120545.34711.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 05:32, Bryan O'Sullivan wrote:
> On Thu, 2006-01-12 at 05:19 +0100, Andi Kleen wrote:
> > My feeling is more and more that this thing is so specialized for your
> > setup and so narrow purpose that you're best off dropping this whole
> > patchkit and just put the assembly into your driver.
>
> But this gave people fits when Roland first posted the driver for
> review.  

Yah, but they clearly didn't see the whole picture back then
(you should probably have explained it better). All the ugly details
were only brought to light on close review.

> There's also no clean, obvious way to make it work on other 
> 64-bit architectures, in that case.

for loop and writel() ? 

-Andi
