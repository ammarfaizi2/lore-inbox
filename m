Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQL2RJi>; Fri, 29 Dec 2000 12:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129930AbQL2RJ2>; Fri, 29 Dec 2000 12:09:28 -0500
Received: from alumnus.caltech.edu ([131.215.50.236]:5810 "EHLO
	alumnus.caltech.edu") by vger.kernel.org with ESMTP
	id <S129257AbQL2RJY>; Fri, 29 Dec 2000 12:09:24 -0500
Date: Fri, 29 Dec 2000 08:38:56 -0800 (PST)
From: "Daniel R. Kegel" <dank@alumni.caltech.edu>
Message-Id: <200012291638.IAA28137@alumnus.caltech.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Petru Paler wrote: 
> > This is one of the main thttpd design points: run in a select() loop. Since 
> > it is intended for mainly static workloads, it performs quite well... 
> 
> It can't scale in SMP. 

thttpd is i/o bound, not CPU bound, so there's no need for SMP scaling.
It's an effective little server as long as the active document
tree fits in RAM.  

If it ain't broke, don't tell people how to fix it :-)

(If for some reason SMP scaling was desirable, the thttpd
way to do it would be to introduce one thread for each
CPU, and have each thread run the same select() loop.)
- Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
