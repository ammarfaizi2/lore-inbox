Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUCLDdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 22:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbUCLDdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 22:33:13 -0500
Received: from kalmia.drgw.net ([209.234.73.41]:55994 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S261932AbUCLDdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 22:33:08 -0500
Date: Thu, 11 Mar 2004 21:33:07 -0600
From: Troy Benjegerdes <hozer@hozed.org>
To: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       infiniband-general@lists.sourceforge.net
Subject: Re: ANNOUCE: OpenIB InfiniBand software
Message-ID: <20040312033307.GA797@kalmia.hozed.org>
References: <52znavp2mk.fsf@topspin.com> <52brn9wv04.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <52brn9wv04.fsf@topspin.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2004 at 01:00:59PM -0800, Roland Dreier wrote:
> Several people have requested that we split the possibly-encumbered
> SDP code into a separate package so that they don't have to download
> it to get the free code.  To allow that, I have split the kernel code
> into two packages:
> 
>     infiniband-kernel-2004-03-05.tar.bz2
>     infiniband-kernel-sdp-2004-03-05.tar.bz2
> 

Since the openib.org mailing lists don't seem to be alive yet, I'll
bring this up here..

Can we get this split out into the following components?

	* kernel level infiniband access layer
	* lowlevel hardware driver (aka mellanox driver)
	* all other 'upper layer protocols'

All the existing code has big problems with how it interfaces to the
kernel memory management.. it doesn't use the regular interfaces like
get_user_pages, pci_map_page, and pci_map_sq, and goes and looks at the
guts of the pagetables directly. 

This is either a problem with the kernel interfaces made available, or a
design issue with the existing codebases. Can someone please tell me
which it is?

-- 
--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@hozed.org  

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's why
I draw cartoons. It's my life." -- Charles Shultz
