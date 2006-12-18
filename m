Return-Path: <linux-kernel-owner+w=401wt.eu-S932233AbWLRXw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWLRXw6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWLRXw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:52:58 -0500
Received: from ozlabs.org ([203.10.76.45]:51878 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932233AbWLRXw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:52:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17799.10706.834077.676728@cargo.ozlabs.ibm.com>
Date: Tue, 19 Dec 2006 10:52:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, Ricardo Galli <gallir@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
In-Reply-To: <Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
References: <200612161927.13860.gallir@gmail.com>
	<Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
	<orwt4qaara.fsf@redhat.com>
	<Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
	<orpsah6m3s.fsf@redhat.com>
	<Pine.LNX.4.64.0612181134260.3479@woody.osdl.org>
	<or64c96ius.fsf@redhat.com>
	<Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> "Derivation" has nothing to do with "linking". Either it's derived or it 
> is not, and "linking" simply doesn't matter. It doesn't matter whether 
> it's static or dynamic. That's a detail that simply doesn't have anythign 
> at all to do with "derivative work".

There is in fact a pretty substantial non-technical difference between
static and dynamic linking.  If I create a binary by static linking
and I include some library, and I distribute that binary to someone
else, the recipient doesn't need to have a separate copy of the
library, because they get one in the binary.

If on the other hand the binary is dynamically linked, then the
recipient needs to get hold of a copy of the library from somewhere,
implying that they need to have satisfied whatever license conditions
the copyright owner of the library places on it, in order to have
obtained their copy of the library legally.

In other words, static linking gives the recipient a "free" copy of
the library, but dynamic linking doesn't.  That is why some companies'
legal guidelines have quite different rules about the distribution of
binaries, depending on whether they are statically or dynamically
linked.

If the library was a proprietary library, for which the copyright
owner wanted to charge a per-copy fee, the owner would no doubt object
to me distributing statically-linked binaries containing his library,
but could conceivably be perfectly happy with me distributing binaries
that have been dynamically linked against his library, since then
anyone who wants to use my binary has to purchase a copy of his
library from him.

So therefore I don't think you can reasonably claim that static
vs. dynamic linking is only a technical difference.  There are clearly
other differences when it comes to distribution of the resulting
binaries.

Paul.
