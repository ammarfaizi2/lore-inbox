Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTKMQsv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 11:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbTKMQsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 11:48:51 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:63401 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264343AbTKMQsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 11:48:50 -0500
Date: Thu, 13 Nov 2003 08:48:01 -0800
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031113164801.GA27268@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20031107102514.A2437@infradead.org> <Pine.SGI.3.96.1031112174709.40512D-100000@fsgi900.americas.sgi.com> <20031113065844.A16234@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113065844.A16234@infradead.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 06:58:44AM +0000, Christoph Hellwig wrote:
> > + 	- please don't kill xbridge support from pcibr, we want to reuse
> > + 	it for the ip27 port soon
> > 
> > Not sure what you mean here. I'm pretty sure if this code is needed for
> > a non-ia64 system it won't be in the sn2 code.
> 
> Well, given that the ip27 is basically the same system architecture as 
> sn2 we want to resuse that code.  Whether it stays in arch/ia64/ or goes
> to drivers/xtalk is a different question.  Also note that you can just
> make the IS_PIC calls evulate to 1 always in your build, any recent gcc
> will optimize away the xbridge codepathes then

Are you sure you want to handle it this way?  I'm not sure the code is
very useful in its current state--I think we might be better off
downloading an old kernel version for reference and writing new code for
drivers/xtalk.

Then again, starting with the existing mips code might be even better
since we know that worked at one point.

Jesse
