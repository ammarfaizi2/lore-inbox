Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbUKSKeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbUKSKeh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 05:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbUKSKeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 05:34:37 -0500
Received: from ns.suse.de ([195.135.220.2]:6616 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261282AbUKSKeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 05:34:20 -0500
Date: Fri, 19 Nov 2004 11:34:19 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
Message-ID: <20041119103418.GB30441@wotan.suse.de>
References: <20041119005117.GM4943@stusta.de> <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419DC922.1020809@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 05:21:22AM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> >On Fri, Nov 19, 2004 at 01:51:17AM +0100, Adrian Bunk wrote:
> >
> >>I'd like to send a patch after 2.6.10 that removes the following from 
> >>arch/x86_64/Kconfig:
> >>
> >> config X86
> >>       bool
> >>       default y
> >
> >
> >I'm against this. Please don't do this.
> 
> An explanation would be nice.

Basically what Paul Menage said. There is a lot of common code,
and you would end up writing X86 && X86_64 more often than
X86 && !X86_64.

In addition such a change is quite intrusive and I don't
think it's a good idea to do right now because it'll very
likely introduce bugs.

If someone really thinks the X86 && !X86_64 is too ugly
(I personally don't think it is because it says clearly
what the matter is) then adding an additional X86_32 would be the right
thing to do.

-Andi
