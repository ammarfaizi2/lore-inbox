Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTIMSxd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTIMSxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:53:33 -0400
Received: from havoc.gtf.org ([63.247.75.124]:46739 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262161AbTIMSxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:53:21 -0400
Date: Sat, 13 Sep 2003 14:53:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913185319.GC10047@gtf.org>
References: <20030913125103.GE27368@fs.tum.de> <20030913161149.GA1750@redhat.com> <20030913182159.GA10047@gtf.org> <20030913183758.GQ1191@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913183758.GQ1191@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 07:37:58PM +0100, Dave Jones wrote:
> On Sat, Sep 13, 2003 at 02:21:59PM -0400, Jeff Garzik wrote:
> 
>  > >  > In 2.4 selecting e.g. M486 has the semantics to get a kernel that runs 
>  > >  > on a 486 and above.
>  > >  > In 2.6 selecting M486 means that only the 486 is supported.
>  > > 
>  > > What are you basing this on ? This seems bogus to me.
>  > > Last I checked, I could for eg, boot a 386 kernel on an Athlon.
>  > 
>  > If you know that you're only booting on a 486, why include all the junk
>  > needed solely for later processors?
> 
> Reread. a kernel _compiled for 386_
> Precisely what junk do you mean ?
> 
>  > > If we boot a 386 kernel on a ppro with that bug, this goes bang.
>  > Echo my first comment.
> 
> Echo 2 lines above. People do use 386 kernels for install kernels
> on distros. Removing errata workarounds means distros start randomly
> exploding during installs.

You're not understanding the model.  I understand your comment about
using 386 kernels for install kernels.  If Adrian's patch is done
right, _absolutely nothing should change_ in your described scenario.

Distros would continue doing what they've always done, and would
continue to get the behavior they have always gotten.

Unless you're a power user and select CONFIG_EMBEDDED, of course.
Then behavior changes.

	Jeff



