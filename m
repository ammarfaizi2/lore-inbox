Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUBRRh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUBRRh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:37:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9092 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267618AbUBRRhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:37:48 -0500
Date: Wed, 18 Feb 2004 17:37:41 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: module unload deadlock
Message-ID: <20040218173740.GB31035@parcelfarce.linux.theplanet.co.uk>
References: <20040217172646.GT4478@dualathlon.random> <20040218041527.052222C510@lists.samba.org> <20040218043555.GY8858@parcelfarce.linux.theplanet.co.uk> <20040218154040.GZ4478@dualathlon.random> <20040218164659.GA31035@parcelfarce.linux.theplanet.co.uk> <20040218172446.GD4478@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218172446.GD4478@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 06:24:46PM +0100, Andrea Arcangeli wrote:
> The one you propose (of parport_pc keeping track of the ports by itself)
> is a different model, currently it's the highlevel that keeps track of
> the ports and each lowlevel registers the lowlevel ports in the
> highlevel list of ports. It doesn't mean the current model is wrong. You
> may not like it and you may find it less efficient, or less clean, or
> whatever, but the current model is definitely legitimate (the parport
> code has the troubles you found in the sharing code locking, but this
> registration model you're complaining about now is legitimate instead).

RTFS.  And realize that parport_enumerate() exports the damn list with no
protection whatsoever.  It is broken and it always had been broken.
