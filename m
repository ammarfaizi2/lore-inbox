Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWGZAGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWGZAGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWGZAGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:06:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57022 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030281AbWGZAGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:06:10 -0400
Date: Tue, 25 Jul 2006 17:05:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rik van Riel <riel@redhat.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
In-Reply-To: <44C6B111.9010502@redhat.com>
Message-ID: <Pine.LNX.4.64.0607251702560.464@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy> <44C30E33.2090402@redhat.com>
 <Pine.LNX.4.64.0607241109190.25634@schroedinger.engr.sgi.com>
 <44C518D6.3090606@redhat.com> <Pine.LNX.4.64.0607251324140.30939@schroedinger.engr.sgi.com>
 <44C68F0E.2050100@redhat.com> <Pine.LNX.4.64.0607251600001.32387@schroedinger.engr.sgi.com>
 <44C6B111.9010502@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, Rik van Riel wrote:

> > Well, I read the whole thing before I replied and I could not figure this
> > one out. Maybe I am too dumb to understand. Could you please explain
> > yourself in more detail
> 
> Page state transitions can be very expensive in a virtualized
> environment, so it would be good if we had fewer transitions.

So the hypervisor indeed tracks each individual page state? Note that I do 
not propose to change the page state but a counter for page states. I am 
bit confused about how not touching a page can cause page state 
transitions. But then I do not know much about hypervisors. What magic is 
going on in the background that could enable the hypervisor to track 
counter increments?


