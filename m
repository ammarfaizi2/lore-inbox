Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132041AbRAJRcg>; Wed, 10 Jan 2001 12:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130339AbRAJRc0>; Wed, 10 Jan 2001 12:32:26 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:62224 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S132041AbRAJRcP>; Wed, 10 Jan 2001 12:32:15 -0500
Date: Wed, 10 Jan 2001 18:32:09 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Alan Shutko <ats@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
In-Reply-To: <874rz7pcwn.fsf@wesley.springies.com>
Message-ID: <Pine.LNX.4.21.0101101759150.16888-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2001, Alan Shutko wrote:

> Marco Colombo <marco@esi.it> writes:
> 
> > But what happens if I delete the stm1 line? We have:
> > 
> > 	case xxx:
> > 		/* fallthrough */
> > 	case yyy:
> > 		stm2;
> > 
> > which is wrong. 
> 
> AFAIK, that's perfectly correct.  It's only the case where you have a
> label at the end of a block (without a statement following it) where
> it's an error.
> 
> In the grammar, a statement must follow a label, but a
> labeled-statement is a type of statement, so you can stack labels as
> much as you want, as long as there's a statement somewhere after them.
> 
> That is, assuming I'm reading the standard right (ISO/IEC 9899:1990,
> Section 6.6, 6.6.1).        

Opps, sorry, I misunderstood Linus' message, then. 

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
