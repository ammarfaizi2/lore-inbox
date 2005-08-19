Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbVHSUzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbVHSUzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVHSUzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:55:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5351 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932255AbVHSUze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:55:34 -0400
Date: Fri, 19 Aug 2005 13:55:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <Pine.LNX.4.60.0508192144590.7312@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0508191352540.3412@g5.osdl.org>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> 
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
 <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org>
 <Pine.LNX.4.60.0508192144590.7312@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Aug 2005, Anton Altaparmakov wrote:
> 
> It does disable link caching.  But I didn't make this up.  This is exactly 
> what smbfs uses.  I just copied smbfs given ncpfs copies almost everything 
> smbfs does anyway...

Can you test whether the untested test-patch I sent out seems to work for 
your case that bugs out? You'll probably get a few new "initialization 
from incompatible pointer type" warnings, but I do believe that they 
should be harmless at least on normal architectures.

		Linus
