Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287647AbSAQBE0>; Wed, 16 Jan 2002 20:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287490AbSAQBES>; Wed, 16 Jan 2002 20:04:18 -0500
Received: from apogee.whack.org ([167.216.255.203]:31481 "EHLO mx1.whack.org")
	by vger.kernel.org with ESMTP id <S287488AbSAQBEE>;
	Wed, 16 Jan 2002 20:04:04 -0500
Date: Wed, 16 Jan 2002 17:03:58 -0800 (PST)
From: Wilson Yeung <wilson@whack.org>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, <linux-net@vger.kernel.org>
Subject: Re: hires timestamps for netif_rx()
In-Reply-To: <20020116.161759.68040363.davem@redhat.com>
Message-ID: <Pine.GSO.4.40.0201161658260.28457-100000@apogee.whack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, David S. Miller wrote:
>    I'd love to have a run-time tuneable kernel parameter that lets me use
>    do_gettimeofday() instead of get_fast_time for received packet
>    timestamping.  Does this seem reasonable?
>
> Can you demonstrate a difference in accurace between these two
> routines on any architecture :-)

The discreprency is that get_fast_time() returns the current value of
xtime, while do_gettimeofday() may actually calculate the time and
consider both xtime and the jiffies.


