Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWFUVhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWFUVhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWFUVhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:37:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:31658 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751262AbWFUVhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:37:38 -0400
Subject: Re: [Lse-tech] [PATCH 00/11] Task watchers:  Introduction
From: Matt Helsley <matthltc@us.ibm.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       "John T. Kohl" <jtk@us.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       LSE <lse-tech@lists.sourceforge.net>
In-Reply-To: <4499222A.5090403@bigpond.net.au>
References: <1150242721.21787.138.camel@stark>
	 <20060619032453.2c19e32c.akpm@osdl.org> <1150878929.21787.956.camel@stark>
	 <20060621020754.59dd42c6.akpm@osdl.org> <1150881185.21787.980.camel@stark>
	 <4499222A.5090403@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 14:32:10 -0700
Message-Id: <1150925530.21787.1060.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 20:40 +1000, Peter Williams wrote:
> Matt Helsley wrote:
> > On Wed, 2006-06-21 at 02:07 -0700, Andrew Morton wrote:
> >> On Wed, 21 Jun 2006 01:35:29 -0700
> >> Matt Helsley <matthltc@us.ibm.com> wrote:

<snip>

> >>> Alternately,
> >>> I could produce patches that apply on top of the current set.
> >> It depends on how many of the existing patches are affected.  If it's just
> >> one or two then an increment would be fine.  If it's everything then a new
> >> patchset I guess.
> > 
> > It would affect most of them -- I'd need to change the bits that
> > register a notifier block. So I'll make a separate series.
> 
> How about making WATCH_TASK_INIT and friends flags so that clients can 
> then pass a mask (probably part of the notifier_block) that specifies 
> which ones they wish to be notified of.  This would save unnecessary 
> function calls.
> 
> Peter

	Yes, I was considering that. However, I realized that it still would
involve either multiple notifier blocks or significant, non-intuitive
changes in the notifier chain code so that one notifier block could be
registered on multiple chains.

	I'll keep this suggestion in mind.

Cheers,
	-Matt Helsley

