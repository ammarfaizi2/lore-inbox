Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUJVSqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUJVSqc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUJVSnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:43:52 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:32434 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266704AbUJVSkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:40:20 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 22 Oct 2004 20:14:57 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Luca Risolia <luca.risolia@studio.unibo.it>,
       Luc Saillard <luc@saillard.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Linux 2.6.9-ac3
Message-ID: <20041022181457.GB8067@bytesex>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it> <20041022092102.GA16963@sd291.sivit.org> <20041022143036.462742ca.luca.risolia@studio.unibo.it> <878y9y269v.fsf@bytesex.org> <1098460282.19459.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098460282.19459.15.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 04:51:23PM +0100, Alan Cox wrote:
> On Gwe, 2004-10-22 at 15:10, Gerd Knorr wrote:
> > The corner case are the vendor-specific compressions.  IMHO it doesn't
> > make much sense to attempt to implement every strange format some
> > engineer invented in every v4l2 application.  Especially if there is
> > no free implementation of it (which is the reason the non-gpl pwcx
> > module was created IIRC).
> 
> The pwc formats look like they can be done a lot faster in MMX, which
> argues for some format of user space exposure and a set of format idents
> for "vendor foo, protocol 0" etc

We'll also need a libv4l2-vendorstuff then (*one* libary for *all* these
vendor formats), otherwise that isn't going to work.  If someone is
willing to create & maintain such a library -- fine with me.  I'll
happily hand out v4l2 vendor format ID's and agree do drop stuff from
kernel space then.  But asking the apps to decode stuff in userspace
without providing a way to do so isn't a good idea.

  Gerd

-- 
return -ENOSIG;
