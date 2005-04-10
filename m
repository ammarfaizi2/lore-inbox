Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVDJQ7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVDJQ7J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 12:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVDJQ7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 12:59:09 -0400
Received: from mail.tmr.com ([216.238.38.203]:38660 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261519AbVDJQ7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 12:59:03 -0400
Date: Sun, 10 Apr 2005 12:46:16 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Junio C Hamano <junkio@cox.net>
cc: David Lang <dlang@digitalinsight.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
In-Reply-To: <7vzmw7as25.fsf@assigned-by-dhcp.cox.net>
Message-ID: <Pine.LNX.3.96.1050410124238.18440A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Apr 2005, Junio C Hamano wrote:

> >>>>> "DL" == David Lang <dlang@digitalinsight.com> writes:
> 
> DL> just wanted to point out that recent news shows that sha1 isn't as
> DL> good as it was thought to be (far easier to deliberatly create
> DL> collisions then it should be)
> 
> I suspect there is no need to do so...

It's possible to generate another object with the same hash, but:
 - you can't just take your desired object and do magic to make it hash
   right
 - it may not have the same length (almost certainly)
 - it's still non-trivial in terms of computation needed

> 
>   Message-ID: <Pine.LNX.4.58.0504090902170.1267@ppc970.osdl.org>
>   From: Linus Torvalds <torvalds@osdl.org>
>   Subject: Re: Kernel SCM saga..
>   Date: Sat, 9 Apr 2005 09:16:22 -0700 (PDT)
> 
>   ...
> 
>                   Linus 
> 
>   (*) yeah, yeah, I know about the current theoretical case, and I don't
>   care. Not only is it theoretical, the way my objects are packed you'd have
>   to not just generate the same SHA1 for it, it would have to _also_ still
>   be a valid zlib object _and_ get the header to match the "type + length"  
>   of object part. IOW, the object validity checks are actually even stricter
>   than just "sha1 matches".
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

