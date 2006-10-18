Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422731AbWJRR1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWJRR1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWJRR1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:27:06 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:13560 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422732AbWJRR1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:27:05 -0400
Date: Wed, 18 Oct 2006 13:26:49 -0400
From: Chris Mason <chris.mason@oracle.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm1
Message-ID: <20061018172649.GA17278@think.oraclecorp.com>
References: <20061016230645.fed53c5b.akpm@osdl.org> <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com> <45364CE9.7050002@yahoo.com.au> <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 10:15:47AM -0700, Badari Pulavarty wrote:
> On Thu, 2006-10-19 at 01:48 +1000, Nick Piggin wrote:
> > Badari Pulavarty wrote:
> > > On Mon, 2006-10-16 at 23:06 -0700, Andrew Morton wrote:
> > > LTP writev tests seems to lockup the machine. reiserfs issue ?
> > 
> > ...
> > 
> > > BUG: soft lockup detected on CPU#2!
> > > 
> > 
> > This is likely to be a reiserfs interaction with the pagecache write
> > deadlock fixes. Chris Mason just now identified a couple of issues
> > and is going to work on a fix.
> > 
> 
> No. seems to be generic issue .. (happens with ext3 also) :(
> 
The reiserfs side should be pages marked up to date when they really
aren't.  Not a good thing, but not softlockup either.

-chris

