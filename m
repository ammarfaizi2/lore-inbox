Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131028AbRCJQQs>; Sat, 10 Mar 2001 11:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131032AbRCJQQi>; Sat, 10 Mar 2001 11:16:38 -0500
Received: from SAUL.CIS.UPENN.EDU ([158.130.12.4]:34288 "EHLO
	saul.cis.upenn.edu") by vger.kernel.org with ESMTP
	id <S131028AbRCJQQY>; Sat, 10 Mar 2001 11:16:24 -0500
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Helge Hafting <helgehaf@idb.hist.no>,
        Manoj Sontakke <manojs@sasken.com>, <linux-kernel@vger.kernel.org>
Subject: Re: quicksort for linked list
In-Reply-To: <Pine.LNX.4.30.0103091240130.5548-100000@waste.org>
From: Jerome Vouillon <vouillon@saul.cis.upenn.edu>
Date: 10 Mar 2001 11:15:32 -0500
In-Reply-To: Oliver Xymoron's message of Fri, 9 Mar 2001 12:52:45 -0600 (CST)
Message-ID: <d3zr905siqj.fsf@saul.cis.upenn.edu>
X-Mailer: Gnus v5.5/Emacs 20.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> writes:

> On Fri, 9 Mar 2001, Rogier Wolff wrote:
> 
> > Quicksort however is an algorithm that is recursive. This means that
> > it can use unbounded amounts of stack -> This is not for the kernel.
> 
> It is of course bounded by the input size, but yes, it can use O(n)
> additional memory in the worst case. There's no particular reason this
> memory has to be on the stack - it's just convenient.

You only need O(log n) additional memory if you sort the shortest
sublist before the longest one (and turn the second recursive call
into a loop).
As log n is certainly less that 64, one can even consider that
Quicksort only uses a bounded amount of memory.

-- Jerome
