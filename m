Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVCaPfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVCaPfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVCaPfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:35:15 -0500
Received: from graphe.net ([209.204.138.32]:5388 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261407AbVCaPfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:35:09 -0500
Date: Thu, 31 Mar 2005 07:35:00 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Christoph Hellwig <hch@infradead.org>
cc: shobhit dayal <shobhit@calsoftinc.com>, manfred@colorfullife.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, Shai Fultheim <shai@scalex86.org>
Subject: Re: Fwd: [PATCH] Pageset Localization V2
In-Reply-To: <20050331143235.GA18058@infradead.org>
Message-ID: <Pine.LNX.4.58.0503310733300.6034@server.graphe.net>
References: <Pine.LNX.4.58.0503292147200.32571@server.graphe.net>
 <20050330111439.GA13110@infradead.org> <bab4333005033003295f487e3d@mail.gmail.com>
 <1112187977.9773.15.camel@kuber> <20050331143235.GA18058@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, Christoph Hellwig wrote:

> On Wed, Mar 30, 2005 at 06:36:18PM +0530, shobhit dayal wrote:
> > The goal here is to replace the head of a existing list pointed to by
> > 'list' with a new head pointed to by 'nlist'.
> > First there is a memcpy that copies the contents of list to nlist then
> > this macro is called.
> > The macro makes sure that if the old head was empty then INIT_LIST_HEAD
> > the 'nlist', if not then make sure that the nodes before and after the
> > head now correclty point to nlist instead of list.
>
> Which would be much nicer done using INIT_LIST_HEAD on the new head
> always and then calling list_replace (of which currently only a _rcu variant
> exists).
>
> Note to Christoph:  Just duplicating the code doesn't make it better ;-)

I will need the loop there for the  prezeroing stuff later.
