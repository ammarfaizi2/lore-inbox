Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932777AbVHTBMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbVHTBMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 21:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbVHTBMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 21:12:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50352 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932777AbVHTBMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 21:12:52 -0400
Date: Sat, 20 Aug 2005 02:15:49 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050820011549.GM29811@parcelfarce.linux.theplanet.co.uk>
References: <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org> <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org> <Pine.LNX.4.60.0508192144590.7312@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0508191352540.3412@g5.osdl.org> <Pine.LNX.4.60.0508192220440.7312@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0508191502050.3412@g5.osdl.org> <20050819231542.GJ29811@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0508191805410.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508191805410.3412@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 06:08:12PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 20 Aug 2005, Al Viro wrote:
> > 
> > That looks OK except for
> > 	* ncpfs fix is actually missing here
> 
> Well, the thing is, with the change to page_follow_link() and 
> page_put_link(), ncpfs should now work fine - it doesn't need any fixing 
> any more.

Ah - right, it's using normal methods...
