Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752578AbWCQJmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbWCQJmS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWCQJmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:42:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:38106 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751212AbWCQJmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:42:17 -0500
Message-ID: <441A8469.8020504@sgi.com>
Date: Fri, 17 Mar 2006 10:42:01 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060223)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, hch@lst.de, cotte@de.ibm.com,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
References: <yq0k6auuy5n.fsf@jaguar.mkp.net> <20060316163728.06f49c00.akpm@osdl.org> <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Quite frankly, I don't think nopfn() is a good interface. It's only usable 
> for one single thing, so trying to claim that it's a generic VM op is 
> really not valid. If (and that's a big if) we need this interface, we 
> should just do it inside mm/memory.c instead of playing games as if it was 
> generic.

Hi Linus,

As Robin mentioned I believe Carsten was also looking for this interface
and I received an email from Bjorn Helgas after posting this stating
that he was also looking for it, so there may be several users for it.

I believe it was originally Christoph who suggested we took this
approach to avoid playing tricks on do_no_page. However, if you have a
suggestion for how to do it in a better way, I shall be happy to try
and implement it that way instead, if you'll share the details.

Cheers,
Jes
