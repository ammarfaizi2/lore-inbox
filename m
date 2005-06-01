Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVFAUr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVFAUr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFAUqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:46:49 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:51979 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261219AbVFAUpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:45:55 -0400
Date: Wed, 1 Jun 2005 22:39:33 +0200
From: Willy Tarreau <willy@w.ods.org>
To: XIAO Gang <xiao@unice.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion on "int len" sanity
Message-ID: <20050601203933.GP18600@alpha.home.local>
References: <429D5E79.2010707@unice.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429D5E79.2010707@unice.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 09:06:33AM +0200, XIAO Gang wrote:
> 
> I would like to make a security suggestion.
> 
> There are many length variables in the kernel, locally declared as "len" 
> or "length", either as "int", "unsigned int" or "size_t". However, 
> declaring a length as "int" leads easily to an erroneous situation, as 
> the author (or even a code checker) might make the implicite hypothesis 
> that the length is positive, so that it is enough to make a sanity check 
> of the kind
> 
> if (length > limit) ERROR;
> 
> which is not enough.
> 
> On the other hand, when a variable is named "len" or "length", it is 
> usually used for length and never should go negative. So could I suggest 
> that the declarations of these variables to be uniformized to "size_t", 
> via a gradual but sysmatic cleanup?

Probably true for most cases, but be careful of code which would use
-1 to report some errors if such thing exists.

Willy

