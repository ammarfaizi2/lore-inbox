Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVJJRSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVJJRSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVJJRSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:18:43 -0400
Received: from hera.kernel.org ([140.211.167.34]:63413 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750997AbVJJRSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:18:41 -0400
Date: Mon, 10 Oct 2005 10:07:24 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: WU Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: [RFC] use radix_tree for non-resident page tracking\
Message-ID: <20051010130724.GB13876@logos.cnet>
References: <20051010130705.GA5026@mail.ustc.edu.cn> <Pine.LNX.4.63.0510100959290.20944@cuia.boston.redhat.com> <20051010162004.GA7958@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010162004.GA7958@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 12:20:04AM +0800, WU Fengguang wrote:
> On Mon, Oct 10, 2005 at 10:00:30AM -0400, Rik van Riel wrote:
> > How are you going to get the inter-reference distance
> > this way?
> > 
> > I do not see how the radix tree provides you with the
> > refault distance, which is needed to estimate the
> > inter-reference distance.
> How about taking down the current sum of `pgfree' in the slot?

Check this radix implementation
 http://marc.theaimsgroup.com/?l=linux-mm&m=112387857203221&w=2

Using a hashtable is much faster though, needs measurement.

