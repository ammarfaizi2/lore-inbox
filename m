Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265876AbUBPU2D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265821AbUBPU1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:27:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:10379 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265879AbUBPU0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:26:19 -0500
Date: Mon, 16 Feb 2004 12:26:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Lehmann <pcg@schmorp.de>
cc: John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
In-Reply-To: <20040216202043.GD17015@schmorp.de>
Message-ID: <Pine.LNX.4.58.0402161223420.30742@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de>
 <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <4031197C.1040909@pobox.com>
 <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202043.GD17015@schmorp.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, Marc Lehmann wrote:
>
> On Mon, Feb 16, 2004 at 11:48:35AM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> > works on the raw byte sequence and isn't confused). Basically accept the
> > fact that UTF-8 strings can contain "garbage", and don't try to fix it up.
> 
> But you are wrong, UTF-8 strings never contain garbage. UTF-8 is
> well-defined and is always proper UTF-8. It's a tautology.
> 
> The evry idea of "UTF-8 with garbage in it" doesn't make sense.

Sure it does.

You live in a theoretical world where
 (a) there is only one standard
 (b) people read it
 (c) people actually follow it and never have bugs

I've got news for you: none of the above is true. 

Which means that IN PRACTICE you will find strings that you think are 
UTF-8-encoded, but that don't end up being proper UTF-8.

That's the difference between real world and theory. 

And you can either write your programs to be "theoretically correct", or 
you can write them to "work".

It's your choice. I know which program I'd prefer to use.

		Linus
