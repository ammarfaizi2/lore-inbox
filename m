Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUHXUx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUHXUx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUHXUxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:53:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52907 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268316AbUHXUxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:53:46 -0400
Date: Tue, 24 Aug 2004 21:53:44 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, reiser@namesys.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040824205343.GE21964@parcelfarce.linux.theplanet.co.uk>
References: <20040824202521.GA26705@lst.de> <412BA741.4060006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412BA741.4060006@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 04:38:25PM -0400, Jeff Garzik wrote:
> Christoph Hellwig wrote:
> > o files as directories
> >   - O_DIRECTORY opens succeed on all files on reiser4.  Besides breaking
> >     .htaccess handling in apache and glibc compilation this also renders
> >     this flag entirely useless and opens up the races it tries to
> >     prevent against cmpletely useless
> 
> 
> Ouch.
> 
> I would definitely classify this as a security hole, since userland 
> definitely uses O_DIRECTORY to avoid races.

Feh.  That's far from the worst parts of the mess introduced by "hybrid"
crap - trivial sys_link(2) deadlocks triggerable by any user rate a bit
higher on the suckitude scale, IMO.
