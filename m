Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSDDDtw>; Wed, 3 Apr 2002 22:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291787AbSDDDtm>; Wed, 3 Apr 2002 22:49:42 -0500
Received: from [202.135.142.194] ([202.135.142.194]:31749 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S290818AbSDDDta>; Wed, 3 Apr 2002 22:49:30 -0500
Date: Thu, 4 Apr 2002 12:02:09 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops cleanup 2/4
Message-Id: <20020404120209.4bfd92d0.rusty@rustcorp.com.au>
In-Reply-To: <jeit79dk3b.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2002 14:48:08 +0200
Andreas Schwab <schwab@suse.de> wrote:

> gcc is correct.  "&array" and "array" are different.  While they represent
> the same address, the types are not compatible.  Eg. for "int array[5]"
> the type of "array" is "int [5]" (decaying to "int *" in most contexts),
> but the type of "&array" is "int (*)[5]" (pointer to array of 5 ints).

Ah, of course.  Thankyou the clue contribution.  I should have thought
harder in the first place.

(To the audience) Patch, of course, is still correct..
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
