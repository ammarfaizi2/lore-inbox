Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUATGCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 01:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUATGCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 01:02:18 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:22631 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265110AbUATGCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 01:02:15 -0500
Date: Tue, 20 Jan 2004 17:00:52 +1100
From: Nathan Scott <nathans@sgi.com>
To: Oliver Kiddle <okiddle@yahoo.co.uk>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure
Message-ID: <20040120060052.GC953@frodo>
References: <7641.1074512162@gmcs3.local> <20040119193837.6369d498.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119193837.6369d498.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 07:38:37PM -0800, Andrew Morton wrote:
> Oliver Kiddle <okiddle@yahoo.co.uk> wrote:
> >
> >  It has happened three times now and on all occasions, I was untarring a
> >  huge file on an XFS partition. I assume the problem is something to do
> >  with VM. The machine has 1GB of RAM which should be plenty. For the
> ...
> You probably should apply this patch to tell us where the allocation
> failures are coming from.  Make sure that CONFIG_KALLSYMS is enabled in
> kernel config.

We do have known issues in XFS on 2.6 with handling certain VM
allocation failures -- maybe hitting that here.  Christoph has
been looking at making XFS do a better job there; __GFP_NOFAIL
allocations failing seem to be the worst issue for us - on the
occasions I've hit that though, its always immediately fatal.

cheers.

-- 
Nathan
