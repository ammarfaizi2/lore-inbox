Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313589AbSDZBLG>; Thu, 25 Apr 2002 21:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313592AbSDZBLF>; Thu, 25 Apr 2002 21:11:05 -0400
Received: from slide.SoftHome.net ([66.54.152.30]:8867 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S313589AbSDZBLE>;
	Thu, 25 Apr 2002 21:11:04 -0400
In-Reply-To: <courier.3CC89816.00006EFA@softhome.net>
            <20020426022445.O14343@suse.de>
From: dmacbanay@softhome.net
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.10 problems
Date: Thu, 25 Apr 2002 19:11:04 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.251.165.205]
Message-ID: <courier.3CC8A928.00000FF4@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes: 

> On Thu, Apr 25, 2002 at 05:58:14PM -0600, dmacbanay@softhome.net wrote: 
> 
>  > 3.  Starting sometime after kernel 2.5.1 (I couldn't compile any kernels 
>  > from then up until 2.5.5) the Evolution email program locks up whenever 
>  > Calender, Tasks, or Contacts is selected.  I have to go to another terminal 
>  > and kill it.  
> 
> Oh, and does this still apply to 2.5.10 ?
> Again, last few lines from an strace to find out what its doing when it locks
> up may be useful. 
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
 

Here's the last lines from the strace output until had to kill it from 
another terminal.  And this occurs in any kernel from 2.5.5 through 2.5.10.  
It may have happened before that also but I wasn't able to compile any 
kernels after 2.5.1 up until 2.5.5. 

David Macbanay 

select(19, [5 8 10 11 12 13 14 15 16 17 18], NULL, [5 8 10 11 12 13 14 15 16 
17 18], NULL) = 1 (in [15])
read(15, "GIOP\1\0\1\0008\0\0\0", 12)   = 12
read(15, "\0\0\0\0\4\366\377\277\1\0\0\0\30\0\0\0\0\0\0\0009\351"..., 56) = 
56
writev(15, [{"GIOP\1\0\1", 7}, {"\1\f\0\0\0", 5}, {"\0\0\0\0", 4}, 
{"\4\366\377\277\0\0\0\0", 8}], 4) = 24
select(19, [5 8 10 11 12 13 14 15 16 17 18], NULL, [5 8 10 11 12 13 14 15 16 
17 18], NULL) = 1 (in [17])
read(17, "GIOP\1\0\1\0004\0\0\0", 12)   = 12
read(17, "\0\0\0\0\364\366\377\277\1\0\0\0\30\0\0\0\0\0\0\0009\351"..., 52) 
= 52
writev(17, [{"GIOP\1\0\1", 7}, {"\1\f\0\0\0", 5}, {"\0\0\0\0", 4}, 
{"\364\366\377\277\0\0\0\0", 8}], 4) = 24
select(19, [5 8 10 11 12 13 14 15 16 17 18], NULL, [5 8 10 11 12 13 14 15 16 
17 18], NULL) = 1 (in [17])
read(17, "GIOP\1\0\1\0008\0\0\0", 12)   = 12
read(17, "\0\0\0\0\364\366\377\277\1\0\0\0\30\0\0\0\0\0\0\0009\351"..., 56) 
= 56
writev(17, [{"GIOP\1\0\1", 7}, {"\1\f\0\0\0", 5}, {"\0\0\0\0", 4}, 
{"\364\366\377\277\0\0\0\0", 8}], 4) = 24
select(19, [5 8 10 11 12 13 14 15 16 17 18], NULL, [5 8 10 11 12 13 14 15 16 
17 18], NULL) = ? ERESTARTNOHAND (To be restarted)
+++ killed by SIGKILL +++ 

