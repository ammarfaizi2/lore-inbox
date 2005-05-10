Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVEJKCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVEJKCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 06:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVEJKCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 06:02:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38605 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261601AbVEJKCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 06:02:14 -0400
Date: Tue, 10 May 2005 11:02:20 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Alexander Nyberg <alexn@telia.com>, Antoine Martin <antoine@nagafix.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050510100220.GC1150@parcelfarce.linux.theplanet.co.uk>
References: <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <1115481468.925.9.camel@localhost.localdomain> <20050507180356.GA10793@ccure.user-mode-linux.org> <20050508001832.GA32143@parcelfarce.linux.theplanet.co.uk> <20050508061044.GB32143@parcelfarce.linux.theplanet.co.uk> <20050509210753.GA1150@parcelfarce.linux.theplanet.co.uk> <20050510022631.GB1150@parcelfarce.linux.theplanet.co.uk> <20050510035052.GA16892@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510035052.GA16892@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 11:50:52PM -0400, Jeff Dike wrote:
> On Tue, May 10, 2005 at 03:26:31AM +0100, Al Viro wrote:
> > Now we have
> > the following:
> > 	uml/i386 - all variants work
> > 	uml/amd64 TT-only - panics in execve() on /sbin/init (hey, a progress)
> > 	uml/amd64 other variants - work
> 
> Nice, send patches when you get a chance?

ftp.linux.org.uk/pub/people/viro/UM*-RC12-rc4.  The first one is your skas0
rediffed to -rc4, the rest - fixes (matching the bug list upthread; the
last two are actually older than the rest, missed them in the original list
of bugs; one is obvious missing include, another is dereferencing userland
pointer instead of dealing with copied value + missing chunk in amd64/tt
sc_copy_...).
