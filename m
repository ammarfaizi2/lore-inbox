Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUAEMTS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbUAEMTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:19:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39564 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263851AbUAEMTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:19:07 -0500
Date: Mon, 5 Jan 2004 13:19:05 +0100
From: Jens Axboe <axboe@suse.de>
To: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File system cache corruption in 2.6?
Message-ID: <20040105121905.GB3124@suse.de>
References: <Pine.LNX.4.58-035.0401050014450.5565@unix49.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58-035.0401050014450.5565@unix49.andrew.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05 2004, Nathaniel W. Filardo wrote:
> Hi all,
> 	I'm trying to work out the cause of a series of issues I've seen
> on my 2.6 machine.  It appears as though files (specifically libraries) in
> memory can get corrupted, resulting in strangeness like segfaults and
> things like "relocation error: can't find symbol ...-VOMD-POINTER" instead
> of "...-VOID-POINTER".

That's a single bit error.

> I don't believe it's actual hardware failure for a few reasons: memtest86
> passes all tests, GCC doesn't crash (it's a Gentoo system, so gcc and I
> are well acquainted - and before I get jumped on, I've installed udev ;)
> ), and most importantly, sometimes thrashing the file system or engaging a
> kernel compile will rectify the situation, as just happened with emacs.
> It crashed, I killed it, it wouldn't load - I started a kernel compile,
> waited a bit, and lo', it works again.  No messages of relevance appear in
> dmesg.

It looks _extremely_ much like bad memory, or bad hardware. Sometimes
memtest just doesn't catch all errors (how long did you run it? needs
several days often).

-- 
Jens Axboe

