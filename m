Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVDOL3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVDOL3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 07:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVDOL3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 07:29:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59076 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261673AbVDOL3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 07:29:09 -0400
Date: Fri, 15 Apr 2005 12:29:08 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       Jesper Juhl <juhl-lkml@dif.dk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/fcntl.c : don't test unsigned value for less than zero
Message-ID: <20050415112908.GZ8669@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.62.0504150303480.3466@dragon.hyggekrogen.localhost> <20050415013100.GY8669@parcelfarce.linux.theplanet.co.uk> <20050415082150.GA19095@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415082150.GA19095@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 09:21:50AM +0100, Christoph Hellwig wrote:
> On Fri, Apr 15, 2005 at 02:31:00AM +0100, Matthew Wilcox wrote:
> > On Fri, Apr 15, 2005 at 03:07:42AM +0200, Jesper Juhl wrote:
> > > 'arg' is unsigned so it can never be less than zero, so testing for that 
> > > is pointless and also generates a warning when building with gcc -W. This 
> > > patch eliminates the pointless check.
> > 
> > Didn't Linus already reject this one 6 months ago?
> 
> I think Linux only complained if we're using some typedef that actually
> may be signed.  For fcntl that 'arg' argument is unsigned and that's hardcoded
> in the ABI.  So the check doesn't make sense at all.

No, it was exactly this patch:
http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/1816.html

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
