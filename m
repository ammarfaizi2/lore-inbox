Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTFOQjM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTFOQjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:39:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10513 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262373AbTFOQjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:39:11 -0400
Date: Sun, 15 Jun 2003 09:52:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org, <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel parameters
In-Reply-To: <20030615125854.GA29458@averell>
Message-ID: <Pine.LNX.4.44.0306150951060.8088-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 15 Jun 2003, Andi Kleen wrote:
> 
> The parse_args call in init/main.c does pointer arithmetic between two 
> different external symbols. This is undefined in C (only pointer arthmetic
> in the same symbol is defined) and gets miscompiled on AMD64 with gcc 3.2,

That's silly. You're making the code less readable, with some silly 
parameters. Why does it get miscompiled on amd64, and let's just fix that 
one.

		Linus

