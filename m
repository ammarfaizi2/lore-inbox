Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266853AbRGFVRK>; Fri, 6 Jul 2001 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbRGFVRA>; Fri, 6 Jul 2001 17:17:00 -0400
Received: from moat2.centtech.com ([206.196.95.21]:1206 "EHLO
	prox.centtech.com") by vger.kernel.org with ESMTP
	id <S266853AbRGFVQs>; Fri, 6 Jul 2001 17:16:48 -0400
Message-ID: <3B462AA8.F7F0089D@centtech.com>
Date: Fri, 06 Jul 2001 16:16:24 -0500
From: Eric Anderson <anderson@centtech.com>
Reply-To: anderson@centtech.com
Organization: Centaur Technology
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.14-5.0smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: BIGMEM kernel question
In-Reply-To: <E15IckP-0004w6-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh. That makes sense.  So how can I change the chunk size from 64k to
something higher (I assume I could set it to 128k to effectively double
that 3GB to 6GB)?  

Eric Anderson


Alan Cox wrote:
> 
> > kernel.  My machine has 4GB of RAM, and 6GB of swap.  It appears that I
> > can only allocate 2930 MB (using heapc_linux and other programs).  What
> > do I need to do to get Linux to allow allocation of all available memory
> 
> A non x86 based computer. Its basically impractical to map more than 3Gb of
> memory to user space per process on x86. You can use mmap and shared memory
> to do DOS EMS like tricks with gig rather than 64K sized chunks but you want
> a real 64bit processor to go further
> 
> Alan

-- 
-------------------------------------------------------------------------------
Eric Anderson	 anderson@centtech.com    Centaur Technology    (512)
418-5792
For every complex problem, there is a solution that is simple, neat, and
wrong.
-------------------------------------------------------------------------------
