Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTLLSMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 13:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTLLSMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 13:12:13 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:6597 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261660AbTLLSMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 13:12:10 -0500
Date: Fri, 12 Dec 2003 10:12:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mem: and Swap: lines in /proc/meminfo
Message-ID: <20031212181206.GL15401@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20031211230511.GI15401@matchmail.com> <Pine.LNX.4.44.0312120658001.17287-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312120658001.17287-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 07:00:30AM -0500, Rik van Riel wrote:
> On Thu, 11 Dec 2003, Mike Fedyk wrote:
> 
> > > Note that the inactive clean pages count (more or less)
> > > as free pages, too.
> > 
> > But I should count it as "Inactive" right?
> 
> Yeah.

OK.

> > What can happen to Inact_clean pages besides being freed, and used on
> > the free memory list?
> 
> The data that's still in the page could be referenced again, in which
> case the page gets moved to the inactive dirty list and from there on
> to the active list.
> 
> In effect, the inactive clean list is a "soft free" list, which means
> we can keep a larger number of pages almost-free, without wasting
> memory.
> 

So it doesn't have to be dirty to go in the dirty list, only referenced?
What about Inact_laundry?
