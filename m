Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbULGP3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbULGP3X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbULGP3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:29:23 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:63365 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261833AbULGP3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:29:18 -0500
Date: Tue, 7 Dec 2004 16:29:19 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: bert hubert <ahu@ds9a.nl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: what does __foo means.
Message-ID: <20041207152919.GA28166@wohnheim.fh-wedel.de>
References: <41B5A5E1.9010608@globaledgesoft.com> <Pine.LNX.4.53.0412071354060.16729@yvahk01.tjqt.qr> <20041207131122.GA25796@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041207131122.GA25796@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 December 2004 14:11:22 +0100, bert hubert wrote:
> 
> Nonsense. The _ is used to provide for a new namespace, __ for a second one.
> It is common to have a public function 'foo()' which does lots of error
> checking and has a stable api. foo() in turn calls _foo() to do the actual
> work, perhaps doing additional checking and verification.
> 
> The _namespace is bound by certain rules, some of which apply to the kernel
> as well. The compiler is free to output symbols in the _Namespace, as well
> as in the __namespace.
> 
> "To get specific, identifiers with two leading underscores are reserved for
>  the compiler as well as identifiers beginning with a single underscore and
>  using an upper case alphabetic character for the second. "
> 
> The linux kernel breaks this by using __ for even more private things.

C99:
"All identifiers that begin with an underscore and either an uppercase
letter or another underscore are always reserved for any use."

That applies to normal userspace programs.  It allows compiler, libc
and possibly the kernel to introduce new identifiers without breaking
existing programs.  If programs break, it is their fault, they
shouldn't have used such identifiers.

The kernel is quite different.  Basically, all identifiers belong to
the kernel, none to libc/gcc (with very few exceptions).  So
developers are free to use that at their pleasure and most stick to
your description in the first paragraph.

Jörn

-- 
You cannot suppose that Moliere ever troubled himself to be original in the
matter of ideas. You cannot suppose that the stories he tells in his plays
have never been told before. They were culled, as you very well know.
-- Andre-Louis Moreau in Scarabouche
