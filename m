Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWHaQ2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWHaQ2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWHaQ2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:28:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61111 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932363AbWHaQ2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:28:06 -0400
Date: Thu, 31 Aug 2006 17:27:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       unionfs@fsl.cs.sunysb.edu
Subject: Re: bug in nfs in 2.6.18-rc5?
Message-ID: <20060831162745.GB23925@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Shaya Potter <spotter@cs.columbia.edu>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	unionfs@fsl.cs.sunysb.edu
References: <44F6F80F.1000202@cs.columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F6F80F.1000202@cs.columbia.edu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 10:54:07AM -0400, Shaya Potter wrote:
> so I'm trying to use unionfs, cachefs and nfs, as cachefs is 2.6.18-rc5 
> right now, thats what I'm testing, but I hit an oops.
> 
> basically unionfs's lookup does a "lookup_one_len()" on the underlying fs.

And there you have the bug already. unionfs must not do this, and given
the past discussion on this the unionfs developers should know that
very well :)

