Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbQKBUGU>; Thu, 2 Nov 2000 15:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbQKBUGK>; Thu, 2 Nov 2000 15:06:10 -0500
Received: from ra.lineo.com ([204.246.147.10]:26019 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129385AbQKBUF4>;
	Thu, 2 Nov 2000 15:05:56 -0500
Message-ID: <3A01C7CD.C5AEB5B5@Rikers.org>
Date: Thu, 02 Nov 2000 13:00:13 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andi Kleen <ak@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <3A01B8BB.A17FE178@Rikers.org> <E13rPhi-0001ng-00@the-village.bc.nu> <20001102201836.A14409@gruyere.muc.suse.de> <3A01BDCD.FCBCFFF8@Rikers.org> <20001102205246.A17332@athlon.random>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/02/2000
 01:05:53 PM,
	Serialize complete at 11/02/2000 01:05:53 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Thu, Nov 02, 2000 at 12:17:33PM -0700, Tim Riker wrote:
> > [..] by adding gcc
> > syntax into it [..]
> 
> I think that's the right path. How much would be hard for you to add gcc syntax
> into your compiler too instead of feeding us kernel patches? Note that it would
> be a big advantage also for userspace (not only kernel uses inline asm and
> other gcc extensions). And probably it would be an improvement to your
> compiler too (since I don't know of other compilers that are as smart as
> gcc in the inline asm syntax :).
> 
> Andrea

I agree there is much that can be done by taking this path. Lineo is
also pursuing this with the compiler vendors. Along the same lines, a
vendor may choose to implement a gcc front end that translates gcc
syntax. All these options have merit.

However, it makes me a bit nervous to take this route. It assumes that
the way gcc does things is the "best way". A more formal route of adding
to the ANSI C standard would involve more eyes and therefore hopefully
add to the quality of what has been done solely for gcc.

This started off with some comments from the group (hpa in particular)
that even between gcc releases, the gcc extensions have been much less
stable that the standard compiler features. The danger of implementing
gcc extensions in another compiler is that these feature are solely
under the control of the gcc team. They are to a large degree
"documented as implemented" and as such can be difficult to determine
the Right Way to implement. The Good Things that are in gcc, that we
believe are implemented the Right Way should probably be added to the
ANSI C spec. The others should be avoided, especially when there is an
existing ANSI C way to do them.
-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
