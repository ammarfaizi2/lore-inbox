Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265927AbUBPWEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUBPWEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:04:46 -0500
Received: from mail.shareable.org ([81.29.64.88]:27780 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265927AbUBPWEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:04:43 -0500
Date: Mon, 16 Feb 2004 22:04:42 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: stty utf8
Message-ID: <20040216220442.GD18853@mail.shareable.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216150501.GC16658@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040216150501.GC16658@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
>      perl -e 'for (glob "*") { rename $_, "ņi-".$_ or die "rename: $!\n"; }'
> 
>    (NB: The prefix string is N WITH CEDILLA followed by "i-").
>    (Hint: it mangles perfectly fine non-ASCII file names).
>
>    Perl has no perfect behaviour to offer, because what should that
>    behaviour be if readdir() might return a non-UTF-8 byte sequence
>    as a name?

I've had someone point out that the perl script mangles non-UTF-8
filenames, and there is no correct behaviour for that case.

In fact the _real_ bug is that it mangles perfectly fine UTF-8 filenames.

It's a Perl quirk, but the behaviour is like that for compatibility
with non-UTF-8 filesystems.  I wanted to show how just using UTF-8 for
filenames isn't _yet_ as straightforward as it should be.

-- Jamie
