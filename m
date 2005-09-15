Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030556AbVIOVii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556AbVIOVii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbVIOVii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:38:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46824 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030556AbVIOVii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:38:38 -0400
Date: Thu, 15 Sep 2005 22:38:38 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
       rmk+serial@arm.linux.org.uk
Subject: Re: [PATCH] epca iomem annotations + several missing readw()
Message-ID: <20050915213838.GA19626@ftp.linux.org.uk>
References: <20050915192704.GC25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509151419160.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509151419160.26803@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 02:23:53PM -0700, Linus Torvalds wrote:
> 
> Gaah.
> 
> On Thu, 15 Sep 2005, Al Viro wrote:
> >  { /* Begin post_fep_init */
> >  
> >  	int i;
> > -	unsigned char *memaddr;
> > -	struct global_data *gd;
> > +	unsigned char __iomem *memaddr;
> > +	struct global_data __iomem *gd;
> 
> Please don't use "[unsigned] char __iomem *".

Not a problem, I simply wanted to keep __iomem stuff apart from driver
cleanups.

> Why? Two reasons:

[obvious - we are in full agreement here]

> I bet the patch would look like a nice cleanup if you did that. Hint, 
> hint.

OK...  I'd rather do that as an incremental, to keep unrelated changes
separate, but I can merge them if you prefer it that way.
