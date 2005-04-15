Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVDOLcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVDOLcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 07:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVDOLcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 07:32:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63641 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261745AbVDOLcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 07:32:19 -0400
Date: Fri, 15 Apr 2005 12:32:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Christoph Hellwig <hch@infradead.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/fcntl.c : don't test unsigned value for less than zero
Message-ID: <20050415113218.GA22528@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, Jesper Juhl <juhl-lkml@dif.dk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0504150303480.3466@dragon.hyggekrogen.localhost> <20050415013100.GY8669@parcelfarce.linux.theplanet.co.uk> <20050415082150.GA19095@infradead.org> <20050415112908.GZ8669@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415112908.GZ8669@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 12:29:08PM +0100, Matthew Wilcox wrote:
> > I think Linux only complained if we're using some typedef that actually
> > may be signed.  For fcntl that 'arg' argument is unsigned and that's hardcoded
> > in the ABI.  So the check doesn't make sense at all.
> 
> No, it was exactly this patch:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/1816.html

Hmm.  Looks I absolutely disagree with Linus on this one ;-)

