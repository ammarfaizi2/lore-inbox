Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSIES6F>; Thu, 5 Sep 2002 14:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSIES6F>; Thu, 5 Sep 2002 14:58:05 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:17671 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318028AbSIES6E>; Thu, 5 Sep 2002 14:58:04 -0400
Date: Thu, 5 Sep 2002 20:02:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, lord@sgi.com
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905200240.A12253@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	lord@sgi.com
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random> <20020905180904.A8406@infradead.org> <20020905184125.GA1657@dualathlon.random> <20020905194649.A11789@infradead.org> <20020905185917.GG1657@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020905185917.GG1657@dualathlon.random>; from andrea@suse.de on Thu, Sep 05, 2002 at 08:59:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 08:59:17PM +0200, Andrea Arcangeli wrote:
> > I think we should take the XFS-specific inode lock around vmtruncate.
> > Need to double-check with Steve.
> 
> this is the function I'm looking at and it's called with xfs specific
> inode lock, and I don't see it grabbed either before calling vmtruncate:

should != do

we either need to use your accessors for i_size or take the XFS inode
lock around vmtruncate.
