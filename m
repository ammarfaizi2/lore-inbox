Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272059AbTHRPcs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272053AbTHRPcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:32:47 -0400
Received: from [63.247.75.124] ([63.247.75.124]:32142 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S272050AbTHRPcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:32:41 -0400
Date: Mon, 18 Aug 2003 11:32:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries.Brouwer@cwi.nl, Dominik.Strasser@t-online.de, hch@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030818153239.GC24693@gtf.org>
References: <UTC200308181219.h7ICJfw14963.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0308180820470.1672-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308180820470.1672-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 08:21:45AM -0700, Linus Torvalds wrote:
> 
> On Mon, 18 Aug 2003 Andries.Brouwer@cwi.nl wrote:
> > 
> > I see that Linus already applied this, but I am quite unhappy with
> > these changes. Entirely needlessly user space software is broken.
> 
> If it's supposed to be exported to user space, it _still_ must not use 
> "u_char", since that isn't namespace-clean.
> 
> If it needs exporting, it must use "__u8".

Maybe I am biased, but I actually prefer to use the C99 size-specific
types, when code will be used outside the kernel tree...  even if that
userland code is entirely Linux-kernel-specific.  I try to avoid "__u<size>"
since it's typically a gcc-specific type.

C99 gave us the tools, we should use them :)

	Jeff


