Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289338AbSA3P6G>; Wed, 30 Jan 2002 10:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289339AbSA3P54>; Wed, 30 Jan 2002 10:57:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24484 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289338AbSA3P5q>;
	Wed, 30 Jan 2002 10:57:46 -0500
Date: Wed, 30 Jan 2002 21:30:47 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: Fw: Writeup on AIO design (uploaded) - corrected url
Message-ID: <20020130213047.A2143@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20020130205115.B1864@in.ibm.com> <20020130104627.N10157@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130104627.N10157@devserv.devel.redhat.com>; from jakub@redhat.com on Wed, Jan 30, 2002 at 10:46:27AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 10:46:27AM -0500, Jakub Jelinek wrote:
> On Wed, Jan 30, 2002 at 08:51:15PM +0530, Suparna Bhattacharya wrote:
> > 
> > Oops, oops, oops, I mispelt the website.
> > It should have been:
> > 
> > http://lse.sourceforge.net/io/aionotes.txt
> 
>   a. User level threads
>         - glibc approach (one user thread per operation ?)
>           poor scalability, performance
> 
> Glibc uses a pool of threads, not one thread per operation.
> All requests against a single file descriptor are served sequentially,
> while for different fds they are served by different threads unless aio
> thread limit has been reached, in which case they are queued too.

Thanks for the clarification.
What is the aio thread limit like ? 

> 
>   b. Pool of threads
>         - have a pool of threads servicing an aio request queue for the
>           task - tradeof between degree of concurrency/utilization and
>           resource consumption.
> 
> 	Jakub
