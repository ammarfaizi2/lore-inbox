Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269651AbRHQDjb>; Thu, 16 Aug 2001 23:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRHQDjV>; Thu, 16 Aug 2001 23:39:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27911 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S269651AbRHQDjK>;
	Thu, 16 Aug 2001 23:39:10 -0400
Message-ID: <3B7C91E1.8D87F916@linux-m68k.org>
Date: Fri, 17 Aug 2001 05:39:13 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <3B7C8196.10D1C867@linux-m68k.org>
		<20010816.193841.98557608.davem@redhat.com>
		<3B7C8AB8.19BF8425@linux-m68k.org> <20010816.201342.99205586.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:

> The cast in the new version is not dumb, it's smart.

Yes, it's the smart version of "min((type)a, (type)b)"...

> It's the programmer saying (to both the reader of the
> code and the compiler) "I want this comparison to use
> type X".  Period.

Why? Why would anyone want this? Do you need this for any other ordinary
compare? (For which the compiler will also generate "dumb" warnings.)

> There is no ambiguity, there are no multiple-evaluation
> issues, and no dumb warnings from the compiler.

I'm all for fixing the multiple-evaluation, but I don't see why this
warning should be dumb. If you don't like it, use "-Wno-sign-compare".

bye, Roman
