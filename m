Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbTBLLbp>; Wed, 12 Feb 2003 06:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTBLLbp>; Wed, 12 Feb 2003 06:31:45 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:60172 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267032AbTBLLbn>; Wed, 12 Feb 2003 06:31:43 -0500
Date: Wed, 12 Feb 2003 11:41:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: LA Walsh <law@tlinx.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lsm truly "generic" allowing complete choice?  Clean? Simple? Idon't think so.
Message-ID: <20030212114131.A4545@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	LA Walsh <law@tlinx.org>, linux-kernel@vger.kernel.org
References: <200302121010.56366.russell@coker.com.au> <004301c2d27d$5997c9e0$1403a8c0@sc.tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <004301c2d27d$5997c9e0$1403a8c0@sc.tlinx.org>; from law@tlinx.org on Wed, Feb 12, 2003 at 01:58:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 01:58:53AM -0800, LA Walsh wrote:
> > From: Russell Coker
> > linux-kernel mailing list removed from the CC list (again), they've 
> > probably heard too much of this discussion already.  
> ---
> 	It was isolation away from the mainline kernel list that allowed
> the current patchwork design.  Attempts to clarify the LSM list charter
> which ended up on lkml resulted in movements to silence those 
> questioning the emperor's new clothes (or lack thereof).  LSM project
> members want their changes in the kernel code *today*.  It is appropriate
> to discuss design methodolgy on the kernel list since design
> methodology discussion was forbidden on lkml as was any interaction 
> with the linux community.  Quite frankly, the brown-nosing, back-slapping
> politics really put a bitter taste on things that were naively believed
> to be based more on technocracy than making people 'look good' and
> commercial self-interest.

Full agreement here.  If the LSM stuff actually was discussed on the
appropinquate list (lkml) we probably wouldn't have much of this mess.

> > If making the DAC code a module slows down non-LSM servers 
> > and takes a lot of 
> > programmer time to implement, is it a useful effort?

First making it a _module_ is silly.  In fact the idea of security
_modules_ is very bad - you need early initialization to have prope
labelling of all objects and subjects in the system.

Having DAC optional by itself sounds like a silly idea, but if it is
a fallout of a generic security model I don't see any reason why we
shouldn't allow it.

