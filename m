Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTLVVzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTLVVzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:55:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:45707 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264496AbTLVVzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:55:09 -0500
Date: Mon, 22 Dec 2003 13:55:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tom Felker <tcfelker@mtco.com>
cc: Stan Bubrouski <stan@ccs.neu.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SCO's infringing files list
In-Reply-To: <200312221519.04677.tcfelker@mtco.com>
Message-ID: <Pine.LNX.4.58.0312221337010.6868@home.osdl.org>
References: <1072125736.1286.170.camel@duergar> <200312221519.04677.tcfelker@mtco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Dec 2003, Tom Felker wrote:
> 
> The original errno.h, from linux-0.01, says it was taken from minix, and goes 
> up to 40.

Good eyes - I only analysed the ctype.h thing, and didn't look up errno.h
in the original sources. errno.h has a _big_ comment saying where the
numbers came from (and some swearwords about POSIX ;)

Looking at signal.h, those numbers also seem to largely match minix. Which
makes sense - I actually had access to them.  

In both cases it's only the numbers that got copied, though. And not all
of them either - for some reason I tried to make the signal numbers match
(probably lazyness - not so much that I cared about the numbers
themselves, but about the list of signal names), but for example the
SA_xxxx macros - in the very same file - bear no relation to the minix
ones.

		Linus
