Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266835AbRGFUgr>; Fri, 6 Jul 2001 16:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266834AbRGFUgg>; Fri, 6 Jul 2001 16:36:36 -0400
Received: from mysql.sashanet.com ([209.181.82.108]:30378 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S266833AbRGFUg2>; Fri, 6 Jul 2001 16:36:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Strange thread behaviour on 8-way x86 machine
Date: Fri, 6 Jul 2001 14:35:33 -0600
X-Mailer: KMail [version 1.2]
Cc: Mike Kravetz <mkravetz@sequent.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0107061624370.17825-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0107061624370.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01070614353314.17811@mysql>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 July 2001 13:24, Rik van Riel wrote:
> On Fri, 6 Jul 2001, Sasha Pachev wrote:
> 
> > Upon further investigation and testing, it turned out that the kernel was 
not
> > at fault - the problem was high mutex contention, which caused frequent
> > context switches, and the idle CPU was apparently from the scheduler 
waiting
> > for the original CPU to become available too often.
> >
> > On a side note, it would be nice if a process could communicate
> > to the kernel that it would rather run on the first available
> > CPU than wait for the perfect one to become available.
> 
> The kernel already does this.

Thanks for the info. Would you mind proving a one line pointer on how to tell 
this to the kernel?

-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
