Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUBYWgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUBYWdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:33:08 -0500
Received: from uranus.md1.de ([217.160.177.133]:63639 "EHLO uranus.md1.de")
	by vger.kernel.org with ESMTP id S261774AbUBYW3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:29:41 -0500
Date: Wed, 25 Feb 2004 23:29:02 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: [ANNOUNCE] new driver for teletext decoder SAA5246A
Message-ID: <20040225222902.GA1259@t-online.de>
References: <20040225113437.GA1824@t-online.de> <20040225041330.51961b28.akpm@osdl.org> <20040225181041.GA2446@t-online.de> <20040225133647.1a9a3231.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225133647.1a9a3231.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yup.  I was suggesting remmoval of the `inline' keyword, rather than
> actually moving the bodies of those functions into the caller.
> 
> I've previously seen significant code size reductions by _not_ inlining
> large functions which had a single call site - just leave them as normal
> out-of-line functions.  So it worth experimenting with - pretty simple to
> do.  But if you're using a recent gcc it's probably inlining the function
> even when it's not marked inline.   Whatever.

Sorry for the misunderstanding. I now tested code size with and without
the inline keyword. It's as you said: In some cases code size increases
in some cases it stays the same, in some cases size decreases. I removed
2 inline statements, this reduced the code size by 34 bytes. It's really
worth experimenting with the inline keyword.

The newly updated patch is located at
http://www.michaelgeng.de/linux/saa5246a-rev2-2.6.3.patch

> > If you want to add the patch, how about the following changelog:
> > 
> > [V4L]: Added new driver for Teletext decoder SAA5246A from Philips
