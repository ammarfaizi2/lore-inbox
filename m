Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbQKEKno>; Sun, 5 Nov 2000 05:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQKEKne>; Sun, 5 Nov 2000 05:43:34 -0500
Received: from [62.172.234.2] ([62.172.234.2]:39062 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129733AbQKEKnQ>;
	Sun, 5 Nov 2000 05:43:16 -0500
Date: Sun, 5 Nov 2000 10:43:56 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Naren Devaiah <naren@cs.pdx.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where is __this_module actually defined?
In-Reply-To: <Pine.GSO.4.21.0011050231120.2808-100000@antares.cs.pdx.edu>
Message-ID: <Pine.LNX.4.21.0011051041310.1171-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2000, Naren Devaiah wrote:

> 
> I've looked in the 2.4.0-pre10 source tree and found it defined as 
> 	extern struct module __this_module;
> in module.h (among other files), but where is it actually defined?
> 

it isn't -- it's magic, of course :). The way it works is for insmod to
arrange things in such a manner that &__this_module resolves to point to
the beginning of module's address space, which happens to contain 'struct
module' at the beginning.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
