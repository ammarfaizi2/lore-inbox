Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267810AbRGRCvw>; Tue, 17 Jul 2001 22:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267811AbRGRCvn>; Tue, 17 Jul 2001 22:51:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61636 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267810AbRGRCvZ>;
	Tue, 17 Jul 2001 22:51:25 -0400
Date: Tue, 17 Jul 2001 22:51:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: dpicard@rcn.com
cc: Aaron Sethman <androsyn@ratbox.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH for Corrupted IO on all block devices
In-Reply-To: <3B54F11A.DD2767E8@psind.com>
Message-ID: <Pine.GSO.4.21.0107172246050.1861-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Jul 2001, David J. Picard wrote:

> The issue was in a stack overflow in the test program, as Alexander
> pointed out. Is the stack order different on Solaris et.al v. Linux?
> Could this be why it worked so well on the other OS's?

Stack on Sparc grows up. On x86 - down. Besides, on a different CPU/platform/
compiler you might get different register allocation and thus have a local
variable overwritten in one case happily survive in another (where it just
happened to live in a register).

