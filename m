Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269506AbRHQCxe>; Thu, 16 Aug 2001 22:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269515AbRHQCxY>; Thu, 16 Aug 2001 22:53:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18439 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S269506AbRHQCxR>;
	Thu, 16 Aug 2001 22:53:17 -0400
Message-ID: <3B7C871E.1B37CA85@linux-m68k.org>
Date: Fri, 17 Aug 2001 04:53:18 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <3B7C7235.1E09C034@linux-m68k.org>
		<20010816.185018.102580124.davem@redhat.com>
		<3B7C8196.10D1C867@linux-m68k.org> <20010816.193841.98557608.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:

> Because comparing a signed value with an unsigned value is a perfectly
> sane operation and one should not have to put dumb casts into the
> expression or change the types just to avoid a compiler warning.

Most of the time that cast isn't needed and rather an indicator that
something else is wrong, right now we don't even have a chance to detect
such a situation.
Second, what's wrong with letting the compiler choose the appropriate
type? The compiler will still do it, if you change one of the types, but
the hardcoded type in min is too easy miss.

bye, Roman
