Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVDOIZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVDOIZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 04:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVDOIXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 04:23:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24214 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261770AbVDOIVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 04:21:55 -0400
Date: Fri, 15 Apr 2005 09:21:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/fcntl.c : don't test unsigned value for less than zero
Message-ID: <20050415082150.GA19095@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, Jesper Juhl <juhl-lkml@dif.dk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0504150303480.3466@dragon.hyggekrogen.localhost> <20050415013100.GY8669@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415013100.GY8669@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 02:31:00AM +0100, Matthew Wilcox wrote:
> On Fri, Apr 15, 2005 at 03:07:42AM +0200, Jesper Juhl wrote:
> > 'arg' is unsigned so it can never be less than zero, so testing for that 
> > is pointless and also generates a warning when building with gcc -W. This 
> > patch eliminates the pointless check.
> 
> Didn't Linus already reject this one 6 months ago?

I think Linux only complained if we're using some typedef that actually
may be signed.  For fcntl that 'arg' argument is unsigned and that's hardcoded
in the ABI.  So the check doesn't make sense at all.

