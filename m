Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTFXSjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTFXSjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:39:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31246 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262610AbTFXSjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:39:12 -0400
Date: Tue, 24 Jun 2003 11:52:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Provide example copy_in_user implementation
In-Reply-To: <20030624102551.GE159@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306241151310.29644-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jun 2003, Pavel Machek wrote:
> 
> ...so it should be exactly as fast.

No it shouldn't. 

You should do the access_ok() only _once_ (well, twice: once for source 
and once for dest).

Also, anything that copies memory one byte at a time is just asking to be 
shot.

		Linus

