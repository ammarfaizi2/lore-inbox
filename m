Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVIMOMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVIMOMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbVIMOMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:12:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62436 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964789AbVIMOMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:12:52 -0400
Date: Tue, 13 Sep 2005 15:12:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: J?rn Engel <joern@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Missing #include <config.h>
Message-ID: <20050913141246.GA3234@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	J?rn Engel <joern@infradead.org>, linux-kernel@vger.kernel.org
References: <20050913135622.GA30675@phoenix.infradead.org> <20050913150825.A23643@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913150825.A23643@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 03:08:26PM +0100, Russell King wrote:
> On Tue, Sep 13, 2005 at 02:56:23PM +0100, J?rn Engel wrote:
> > After spending some hours last night and this morning hunting a bug,
> > I've found that a different include order made a difference.  Some
> > files don't work correctly, unless config.h is included before.
> 
> I'm still of the opinion that we should add
> 
> 	-imacros include/linux/config.h
> 
> to the gcc command line and stop bothering with trying to get
> linux/config.h included into the right files and not in others.
> (which then means we can eliminate linux/config.h from all files.)

Yes, absolutely.  That would help fixing lots of mess.

