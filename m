Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289315AbSA3Pq4>; Wed, 30 Jan 2002 10:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289326AbSA3Pqq>; Wed, 30 Jan 2002 10:46:46 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:55236 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289315AbSA3Pqb>; Wed, 30 Jan 2002 10:46:31 -0500
Date: Wed, 30 Jan 2002 10:46:27 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: Fw: Writeup on AIO design (uploaded) - corrected url
Message-ID: <20020130104627.N10157@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20020130205115.B1864@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130205115.B1864@in.ibm.com>; from suparna@in.ibm.com on Wed, Jan 30, 2002 at 08:51:15PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:51:15PM +0530, Suparna Bhattacharya wrote:
> 
> Oops, oops, oops, I mispelt the website.
> It should have been:
> 
> http://lse.sourceforge.net/io/aionotes.txt

  a. User level threads
        - glibc approach (one user thread per operation ?)
          poor scalability, performance

Glibc uses a pool of threads, not one thread per operation.
All requests against a single file descriptor are served sequentially,
while for different fds they are served by different threads unless aio
thread limit has been reached, in which case they are queued too.

  b. Pool of threads
        - have a pool of threads servicing an aio request queue for the
          task - tradeof between degree of concurrency/utilization and
          resource consumption.

	Jakub
