Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271938AbTHRPUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272059AbTHRPUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:20:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:10171 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271938AbTHRPUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:20:35 -0400
Date: Mon, 18 Aug 2003 08:20:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jamie Lokier <jamie@shareable.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use simple_strtoul for unsigned kernel parameters 
In-Reply-To: <20030818101524.5B12D2C019@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0308180817360.1672-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Aug 2003, Rusty Russell wrote:
> 
> Half right.  The second part is fine, the first part is redundant
> AFAICT.

Well, in theory short/int/long can all be the same size and thus a
"unsigned short" may not actually fit in a "long". I think that was the
case on the old 64-bit cray machines, for example ("char" was a very slow
8-bit thing, everything else was purely 64-bit).

Not likely something we want to port Linux to, admittedly.

		Linus

