Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWEWC22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWEWC22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 22:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWEWC22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 22:28:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37520 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751254AbWEWC22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 22:28:28 -0400
Date: Mon, 22 May 2006 19:28:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: cpusets: only wakeup kswapd for zones in the current cpuset
In-Reply-To: <20060522192248.b114fea3.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0605221925350.7272@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081010440.2648@schroedinger.engr.sgi.com>
 <20060522182356.fbea4aec.pj@sgi.com> <Pine.LNX.4.64.0605221858250.7165@schroedinger.engr.sgi.com>
 <20060522192248.b114fea3.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2006, Paul Jackson wrote:

> > None if that is the case.
> 
> Take a look at wakeup_kswapd() for yourself ;).
> No need to speculate.

Yes there is a check in wakeup_kswapd(). Remove the patch. It was quite a 
while ago. I think I saw various functions in __alloc_pages() only being 
called after checking cpusets. wakeup_kswapd() did not have that check 
which was strange.
