Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTDUXzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTDUXzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:55:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4880 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262693AbTDUXzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:55:18 -0400
Date: Mon, 21 Apr 2003 17:06:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <jamie@shareable.org>
cc: Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Runtime memory barrier patching
In-Reply-To: <20030421233557.GB17595@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0304211705400.17938-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Jamie Lokier wrote:
> 
> Such as removing the lock prefix when running non-SMP?

I think you should use a separate mechanism for that. It's really a 
separate issue, _and_ the replacement is actually quite different (and 
much more common, so you'd want to use a more compact data structure that 
is likely just the list of addresses of locked instructions).

		Linus

