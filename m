Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbRGXMct>; Tue, 24 Jul 2001 08:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbRGXMc3>; Tue, 24 Jul 2001 08:32:29 -0400
Received: from mail.intrex.net ([209.42.192.246]:56082 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S267495AbRGXMcX>;
	Tue, 24 Jul 2001 08:32:23 -0400
Date: Tue, 24 Jul 2001 08:38:09 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Optimization for use-once pages
Message-ID: <20010724083809.A1374@bessie.localdomain>
In-Reply-To: <01072405473005.00301@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01072405473005.00301@starship>; from phillips@bonn-fries.net on Tue, Jul 24, 2001 at 05:47:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 05:47:30AM +0200, Daniel Phillips wrote:

> So I decided to look for a new way of approaching the use-once problem 
> that would easily integrated with our current approach.   What I came 
> up with is pretty simple: instead of starting a newly allocated page on 
> the active ring, I start it on the inactive queue with an age of zero. 
> Then, any time generic_file_read or write references a page, if its 
> age is zero, set its age to START_AGE and mark it as unreferenced.

This is wonderfully simple and ellegant.

Jim
