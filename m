Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287276AbSAUQQu>; Mon, 21 Jan 2002 11:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287293AbSAUQQk>; Mon, 21 Jan 2002 11:16:40 -0500
Received: from srv01s4.cas.org ([134.243.50.9]:24319 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S287276AbSAUQQe>;
	Mon, 21 Jan 2002 11:16:34 -0500
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200201211616.LAA16837@mah21awu.cas.org>
Subject: Re: vm philosophising
To: docwhat@gerf.org (The Doctor What)
Date: Mon, 21 Jan 2002 11:16:22 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020121095046.A30401@gerf.org> from "The Doctor What" at Jan 21, 2002 09:50:46 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> * Tommy Faasen (faasen@xs4all.nl) [020118 08:47]:
> > 2-DBMS: 1 or 2 big programs which sometimes even do their own
> > memory management.Fragmentation and latency isn't issue here I
> > think however moving ltos of data to and from swap is.
> 
> A lot of times a DBMS is bulit that way because they assume they
> know better than the OS designer how memory should be managed.  Same
> reason they usually use raw writting the the drive instead of using
> the OS calls.

Actually this isn't true. DBMS usually handle their own memory because
everything is done in blocks of the same size. Since this is configured
as part of the DBMS' parameters, it is much better at handling this
than the OS ever could be, once it has garnered the original memory
from the OS. Remember, this space is normally shared memory as well.

As for the FS, DBMS' prefer raw devices for consistency issues (as
well as speed). Raw devices prevent the use of the kernel's internal
buffers for files (thus reducing the number of memory copies involved).

/Mike
