Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUGJSol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUGJSol (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266342AbUGJSoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:44:39 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:27559 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266341AbUGJSof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:44:35 -0400
Date: Sat, 10 Jul 2004 11:43:57 -0700
From: Chris Wedgwood <cw@f00f.org>
To: L A Walsh <lkml@tlinx.org>
Cc: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040710184357.GA5014@taniwha.stupidest.org>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <40EEC9DC.8080501@tlinx.org> <20040709215955.GA24857@taniwha.stupidest.org> <40F03665.90108@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F03665.90108@tlinx.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 11:33:09AM -0700, L A Walsh wrote:

> My cases have been "vim" edited files.  I'd sorta think once vim has
> exited, the data has been flushed, but that's just a WAG...

No, that's not the case.  Normally when files are written the data
isn't not flushed immediately, it sits in memory (the page-cache) for
some (usually) small amount of time.

If the data is critical applications should fsync (or similar) as
required.

FWIW my standard method of shutdown is:

     sync ; poweroff -f

sorta thing.  I don't loose any data doing this, (at least nothing
I've noticed).


   --cw
