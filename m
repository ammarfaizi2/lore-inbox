Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTKJF4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 00:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTKJF4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 00:56:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4801 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262925AbTKJF4G
	(ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 00:56:06 -0500
Date: Mon, 10 Nov 2003 05:56:04 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       Burton Windle <bwindle@fint.org>, Linux-kernel@vger.kernel.org
Subject: Re: slab corruption in test9 (NFS related?)
Message-ID: <20031110055603.GF7665@parcelfarce.linux.theplanet.co.uk>
References: <16303.131.838605.661991@notabene.cse.unsw.edu.au> <Pine.LNX.4.44.0311092007451.3002-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311092007451.3002-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 08:09:40PM -0800, Linus Torvalds wrote:
> 
> On Mon, 10 Nov 2003, Neil Brown wrote:
> >
> > An extra dput was introduced in nfsd_rename 20 months ago....
> > 
> > time to remove it.
> 
> Oh, you stand-up comedian you.
> 
> I'm just wondering how the hell this hasn't bit us seriously until now?  
> What's up?
> 
> In other words, your patch certainly looks obviously correct, but it also
> looks _so_ obviously correct that my alarm bells are going off. If the
> code was quite that broken at counting dentries, how the hell did it ever
> work AT ALL?
> 
> Call me suspicious, but I find this really strange..

Arrgh...

No, Neil is right - it was a plain and simple fsckup on my part.  No hidden
logics is there; his fix is correct.
