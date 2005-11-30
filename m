Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVK3PSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVK3PSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVK3PSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:18:49 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:65238 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S1751268AbVK3PSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:18:49 -0500
Date: Wed, 30 Nov 2005 17:18:47 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
Message-ID: <20051130151847.GE5706@mea-ext.zmailer.org>
References: <20051130042118.GA19112@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130042118.GA19112@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 11:21:18PM -0500, Benjamin LaHaise wrote:
> Date:	Tue, 29 Nov 2005 23:21:18 -0500
> From:	Benjamin LaHaise <bcrl@kvack.org>
> To:	Andi Kleen <ak@suse.de>
> Cc:	linux-kernel@vger.kernel.org
> Subject: [PATCH 0/9] x86-64 put current in r10
> 
> Hello Andi,
> 
> The following emails contain the patches to convert x86-64 to store current 
> in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).  This 
> provides a significant amount of code savings (~43KB) over the current 
> use of the per cpu data area.  I also tested using r15, but that generated 
> code that was larger than that generated with r10.  This code seems to be 
> working well for me now (it stands up to 32 and 64 bit processes and ptrace 
> users) and would be a good candidate for further exposure.

I would rather prefer NOT to introduce this at this time.
My primary concern is that during "even numbered series" there
should not be radical internal ABI/API changes, like this one.

In 2.7 it can be introduced, by all means.

Indeed at the moment my thinking is, that X86-64 is way more UNSTABLE,
than it should be.  (And Linux kernel overall, but that is another story.)


> 		-ben

/Matti Aarnio
