Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbUK3Bnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbUK3Bnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 20:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUK3Bnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 20:43:41 -0500
Received: from palrel10.hp.com ([156.153.255.245]:28611 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261633AbUK3Bni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:43:38 -0500
Date: Mon, 29 Nov 2004 17:43:28 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>, Mariusz Mazur <mmazur@kernel.pl>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130014328.GA14337@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote :
> We've been discussing splitting the kernel headers into userspace API headers
> and kernel internal headers and deprecating the __KERNEL__ macro.

Linus Torvalds wrote :
> On Mon, 29 Nov 2004, Alexandre Oliva wrote:
> >
> > - Linux gets to define the ABI between kernel and userland, and
> >   userland must duplicate the contents of headers in which the kernel
> >   defines the kernel<->userland ABI, tracking changes in them in the
> >   hope that nothing falls through the cracks
> 
> This is unquestionably true. The kernel obviously _does_ define the ABI, 
> and userland just lives with it. At some point you have to track things, 
> just because new features etc just can't be sanely handled any other way. 
> 
> That said, I think we can make the tracking _easier_. 

	Nice discussion, but nobody is discussing my main concern,
even if Linus come close to it.
	On my box, I do have multiple kernels. Some 2.4.X, some 2.6.X,
I may even find some 2.2.X on some of my boxes. Depending on what I
do, and the bug reports send to me, I boot one of these kernel or
another. Because Linus is so productive, I update my kernel
frequently, without changing the user space. I know that some
distributions are also offering various kernel versions, and let the
user choose.
	So, which kernel ABI should be present on my system in
/usr/include/linux and /usr/include/asm ? Should I use the ABI from
2.6.X, 2.4.X or 2.2.X ? Should I take the time to create a sanitised
version of the kernel header every time I install a new kernel, even
though I may revert back to the previous kernel ? Should I recompile
applications using kernel headers at each kernel upgrade ?
	Currently, it doesn't matter, as so few applications are using
those headers, and most changes are highly backward compatible. And
the application that are deeply intimate with the kernel probably do
run-time tracking of features already, so don't really need those
headers...

	However, I believe we need to at least ask this question, even
if I don't think we will come up with a good answer...

	Have fun...

	Jean
