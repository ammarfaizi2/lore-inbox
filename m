Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278139AbRJRU57>; Thu, 18 Oct 2001 16:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278143AbRJRU5t>; Thu, 18 Oct 2001 16:57:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33811 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S278139AbRJRU5j>; Thu, 18 Oct 2001 16:57:39 -0400
Date: Thu, 18 Oct 2001 17:36:39 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Write throughput in >= 2.4.10
In-Reply-To: <87669c92ye.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.21.0110181735482.12429-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 18 Oct 2001, Zlatko Calusic wrote:

> It looks like recent kernels have some serious trouble during simple
> writing of files. Throughput is cut to half.
> 
> 2.4.12-ac3 (Riel VM):
> 
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  4  1      0   2548   7652 369104   0   0     0 21992  291   592   0  23  77
>  0  4  1      0   2556   7652 369104   0   0     0 22500  280   175   0   3  97
>  0  4  1      0   3064   7652 368588   0   0     8 19644  278   202   0   4  96
> ...
> 
> 2.4.13-pre4 (Andrea/Linus VM):
> 
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  1  1  1  30312   2884   2304 384076   0  28     0  7784  199   241   0  12  88
>  0  1  1  30316   2068   2256 385772   0 132     4  7900  186   188   1   8  91
>  0  1  0  30316   3960   2232 384140   0   0     8  6744  179   204   0   4  96
> ...
> 
> 'bo' column is the one to check out... I copied just 3 lines, but they
> are all alike. 2.4.13-pre ends up with 11MB/sec, where -ac kernels are
> over 20MB/sec (during sequential writing of big files - ext2 of course).
> 
> Also it looks like pre4 swaps when it is not necessary to do so. With
> 380MB in page cache I don't expect any swap traffic at all.

Zlatko, 

Could you please try 2.4.12-pre3 instead pre4 ?

Linus has made some changes and I want to see if those are partly
responsible for the problems you're seeing.

Thanks


