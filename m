Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314735AbSEPVZA>; Thu, 16 May 2002 17:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314740AbSEPVY7>; Thu, 16 May 2002 17:24:59 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18671 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314735AbSEPVY6>; Thu, 16 May 2002 17:24:58 -0400
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15)
	kernel.
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mgross@unix-os.sc.intel.com, Daniel Jacobowitz <dan@debian.org>,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E178SrT-00057L-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 May 2002 14:24:39 -0700
Message-Id: <1021584279.914.4.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-16 at 14:32, Alan Cox wrote:
> > For this to happen that semaphore would have to held across schedule()'s.  
> > The ONLY place I've seen that in the kernel is set_CPUs_allowed + 
> > migration_thread.  
>
> The 2.5 kernel is pre-emptible.

Indeed :)

But there is plenty of places in the kernel - sans preemption - where we
sleep while holding a semaphore.  Was that the original question?  If
so, set_cpus_allowed by be one of the few _explicit_ places but we
implicitly sleep holding a semaphore all over.  Heck, we use them for
user-space synchronization.

	Robert Love

