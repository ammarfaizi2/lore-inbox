Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUBJWZz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUBJWZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:25:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:60049 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261889AbUBJWZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:25:36 -0500
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040210173738.GA9894@mail.shareable.org>
References: <1076384799.893.5.camel@gaston>
	 <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
	 <20040210173738.GA9894@mail.shareable.org>
Content-Type: text/plain
Message-Id: <1076451903.874.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 11 Feb 2004 09:25:03 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The real question is - why does malloc() break?  I'd expect malloc()
> to use MAP_ANON these days, when brk() fails.  But it seems not.

I don't know, trying to find my way in glibc mess^H^H^H^Hsource...

Well, it's non-obvious, it should have fallen back to mmap, unless
something wrong in the glibc build undefined HAVE_MMAP ...

Ben.

