Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbVISSa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVISSa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVISSa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:30:59 -0400
Received: from dsl081-059-088.sfo1.dsl.speakeasy.net ([64.81.59.88]:50878 "EHLO
	piratehaven.org") by vger.kernel.org with ESMTP id S932560AbVISSa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:30:59 -0400
Date: Mon, 19 Sep 2005 11:30:58 -0700
From: Brian Pomerantz <bapper@piratehaven.org>
To: rishikeshsn <rishikeshsn@indiatimes.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: to see 802.11 frames thru kernel code
Message-ID: <20050919183058.GA477@skull.piratehaven.org>
References: <200509191711.WAA28816@WS0005.indiatimes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509191711.WAA28816@WS0005.indiatimes.com>
User-Agent: Mutt/1.4.2.1i
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 10:53:22PM -0400, rishikeshsn wrote:
> hello,
> 
> i want to know:
> 
> can i see 802.11 frames in skbuff structure?
> I get only ethernet II frame format.
> 
> thanks already for help.
> 

This is hardware and driver specific.  Most of the time, the driver
will have access to the 802.11 header, however, it will reformat the
packet into a standard ethernet frame before passing it up to the
network layer.

So, no you cannot see the 802.11 header in a sk_buff because it is
already stripped off.  If you look in the driver before it hits the
network layer (in the rx routine) then you may be able to get access
to it there.


BAPper
