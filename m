Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSJ1SXG>; Mon, 28 Oct 2002 13:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSJ1SXG>; Mon, 28 Oct 2002 13:23:06 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:3848 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261338AbSJ1SXE>; Mon, 28 Oct 2002 13:23:04 -0500
Date: Mon, 28 Oct 2002 18:29:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Matt D. Robinson" <yakker@aparity.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: [PATCH] LKCD for 2.5.44 (8/8): dump driver and build files
Message-ID: <20021028182916.A23504@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	"Matt D. Robinson" <yakker@aparity.com>,
	linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210230244560.27315-100000@nakedeye.aparity.com> <20021023184020.D16547@infradead.org> <20021024192659.A3613@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021024192659.A3613@in.ibm.com>; from suparna@in.ibm.com on Thu, Oct 24, 2002 at 07:26:59PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 07:26:59PM +0530, Suparna Bhattacharya wrote:
> On Wed, Oct 23, 2002 at 07:58:49PM +0000, Christoph Hellwig wrote:
> > > +	}
> > 
> > You need to call bd_claim to get exclusion on the bdev.
> > 
> 
> Won't there be a clash when it comes to setting up swap as
> the dump device ?

Yes, if you dump to swap you have to claim sys_swapon as the swap code does.

