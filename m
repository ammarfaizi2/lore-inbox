Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266890AbRGLWAg>; Thu, 12 Jul 2001 18:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266867AbRGLWA0>; Thu, 12 Jul 2001 18:00:26 -0400
Received: from sciurus.rentec.com ([192.5.35.161]:7094 "EHLO
	sciurus.rentec.com") by vger.kernel.org with ESMTP
	id <S266890AbRGLWAK>; Thu, 12 Jul 2001 18:00:10 -0400
Date: Thu, 12 Jul 2001 18:00:15 -0400 (EDT)
From: Dirk Wetter <dirkw@rentec.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>, <riel@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: dead mem walking ;-) 
In-Reply-To: <Pine.LNX.4.21.0107121717120.2582-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107121753321.2326-100000@monster000.rentec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2001, Marcelo Tosatti wrote:


> > a while before the jobs were submitted i did "readprofile | sort -nr | head -10":
> > 296497 total                                      0.3442
> > 295348 default_idle                             5679.7692
> >    300 __rdtsc_delay                             10.7143
> >    215 si_swapinfo                                1.2500
> >    138 do_softirq                                 1.0147
> >    107 printk                                     0.2816
> >     28 do_wp_page                                 0.0272
> >     17 schedule                                   0.0117
> >     10 tcp_get_info                               0.0077
> >     10 filemap_nopage                             0.0073
> >
> > the same after i was able to kill the jobs (see below):
> >
> > 836552 total                                      0.9710
> > 458757 default_idle                             8822.2500
> > 361961 __get_swap_page                          665.3695
> >   6629 si_swapinfo                               38.5407
> >   1655 do_anonymous_page                          5.3734
> >    760 file_read_actor                            3.0645
> >    652 statm_pgd_range                            1.6633
> >    592 do_softirq                                 4.3529
> >    498 skb_copy_bits                              0.5845
> >    302 __rdtsc_delay                             10.7857
>
>
> Ok, I've seen that before. __get_swap_page() is horribly innefficient.

:-(

> The system is _not_ swaping out data, though. Its just aging the
> pte's and allocating swap.

with that jobs it looks to me that swap allocation shouldn't be
neccessary? total of all pages should have been below the physcial mem
size.


> And that is what is eating the system performance.

does it bring up the load up to 30 and make the machine unusable?
(kswapd was also sometimes in the top-list of CPU hogs, but since i
sorted it by memory...)

> <snip>
>
> Can you please show us the output of /proc/meminfo when the system is
> behaving badly ?

hold on, we set s.th. up....

	~dirkw

