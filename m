Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267188AbUBMU1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267192AbUBMU1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:27:51 -0500
Received: from mail.shareable.org ([81.29.64.88]:54402 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267188AbUBMU1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:27:50 -0500
Date: Fri, 13 Feb 2004 20:27:47 +0000
From: Jamie Lokier <jamie@shareable.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Valdis.Kletnieks@vt.edu, Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
       linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213202747.GB29824@mail.shareable.org>
References: <1076604650.31270.20.camel@ulysse.olympe.o2t> <20040213030346.GF25499@mail.shareable.org> <1076695606.23795.23.camel@m222.net81-64-248.noos.fr> <20040213181542.GD8858@parcelfarce.linux.theplanet.co.uk> <200402131824.i1DIOX6o023463@turing-police.cc.vt.edu> <20040213183148.GF8858@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213183148.GF8858@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> You try and pass something _without_ \0 in it to the kernel ;-)

:)

But seriously, even that is a security issue when someone requests a
URL containing "%00", or some text contains a filename to operate on
and the name contains \0.

For example, if I write a Perl regular expression to reject paths from
the outside world containing "..": m{(?:/|^)\.\.(?:/|\z)}, it will
fail to notice when given the path "..\0" that the kernel will treat
it identically to "..".  Potential security hole, depending on the context.

-- Jamie
