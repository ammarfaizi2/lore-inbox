Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVCaPg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVCaPg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVCaPg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:36:29 -0500
Received: from graphe.net ([209.204.138.32]:11532 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261414AbVCaPgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:36:23 -0500
Date: Thu, 31 Mar 2005 07:36:07 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Matthew Wilcox <matthew@wil.cx>
cc: Christoph Hellwig <hch@infradead.org>,
       shobhit dayal <shobhit@calsoftinc.com>, manfred@colorfullife.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, Shai Fultheim <shai@scalex86.org>
Subject: Re: Fwd: [PATCH] Pageset Localization V2
In-Reply-To: <20050331144740.GB21986@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0503310735150.6034@server.graphe.net>
References: <Pine.LNX.4.58.0503292147200.32571@server.graphe.net>
 <20050330111439.GA13110@infradead.org> <bab4333005033003295f487e3d@mail.gmail.com>
 <1112187977.9773.15.camel@kuber> <20050331143235.GA18058@infradead.org>
 <20050331144740.GB21986@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, Matthew Wilcox wrote:

> On Thu, Mar 31, 2005 at 03:32:35PM +0100, Christoph Hellwig wrote:
> > Which would be much nicer done using INIT_LIST_HEAD on the new head
> > always and then calling list_replace (of which currently only a _rcu variant
> > exists).
>
> INIT_LIST_HEAD followed by list_splice() should do the trick, I think.
> BTW, is it a problem that the list head which the list was copied from
> still points into the list?

The code runs during startup and the section containing the old pointers
is discarded at the end of the boot process.
