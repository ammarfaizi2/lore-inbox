Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131216AbRAJQx6>; Wed, 10 Jan 2001 11:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132477AbRAJQxj>; Wed, 10 Jan 2001 11:53:39 -0500
Received: from mx2.srv.hcvlny.cv.net ([167.206.112.45]:50373 "EHLO
	mx2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S131216AbRAJQxb>; Wed, 10 Jan 2001 11:53:31 -0500
To: Marco Colombo <marco@esi.it>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
In-Reply-To: <Pine.LNX.4.21.0101101619230.16888-100000@Megathlon.ESI>
From: Alan Shutko <ats@acm.org>
Date: 10 Jan 2001 11:52:56 -0500
In-Reply-To: <Pine.LNX.4.21.0101101619230.16888-100000@Megathlon.ESI>
Message-ID: <874rz7pcwn.fsf@wesley.springies.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.95
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Colombo <marco@esi.it> writes:

> But what happens if I delete the stm1 line? We have:
> 
> 	case xxx:
> 		/* fallthrough */
> 	case yyy:
> 		stm2;
> 
> which is wrong. 

AFAIK, that's perfectly correct.  It's only the case where you have a
label at the end of a block (without a statement following it) where
it's an error.

In the grammar, a statement must follow a label, but a
labeled-statement is a type of statement, so you can stack labels as
much as you want, as long as there's a statement somewhere after them.

That is, assuming I'm reading the standard right (ISO/IEC 9899:1990,
Section 6.6, 6.6.1).        

-- 
Alan Shutko <ats@acm.org> - In a variety of flavors!
Programmers do it bit by bit.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
