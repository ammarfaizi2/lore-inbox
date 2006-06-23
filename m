Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752020AbWFWUO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbWFWUO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbWFWUO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:14:56 -0400
Received: from web33303.mail.mud.yahoo.com ([68.142.206.118]:62885 "HELO
	web33303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752019AbWFWUOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:14:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ozrcWJWDRxXD7Z2R5hDVsrRGZ0nFEdiF3AMPaE2rNSeiBnhg3Dn1FsxhpkhWjmgtbUsBO+tSAEedRp3tMGpRkOAa5QMA+y6PEz0c4O9rN1xt2S9zEHD3loTajKTc1muGz0FQvaYBfe4nD2/FKCmsz3eDjd6lml0B+xt1Ihz5Ai0=  ;
Message-ID: <20060623201454.68199.qmail@web33303.mail.mud.yahoo.com>
Date: Fri, 23 Jun 2006 13:14:54 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Measuring tools - top and interrupts
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1151051543.11381.43.camel@Homer.TheSimpsons.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Mike Galbraith <efault@gmx.de> wrote:

> On Thu, 2006-06-22 at 16:37 -0700, Danial Thom
> wrote:
> > I'm sorry, but you're being an idiot if you
> think
> > that 16K interrupts per second and forwarding
> 75K
> > pps generate no cpu load. Its just that
> simple.
> > It also means that you've never profiled a
> kernel
> > because you don't understand where the loads
> are
> > generated. You've probably been on too many
> lists
> > with too many people who have no idea what
> > they're talking about.
> 
> (what horrid manners)
> 
> Hm.  You may be right about the load average
> calculation being broken.
> 
> Below is a 100 second profile sample of my 3GHz
> P4 handling 15K
> interrupts per second while receiving a flood
> ping.  My interpretation
> is that tools should be showing ~10% cpu load
> rather than zero.  Am I'm
> misinterpreting it?
> 
>  97574 total                                   
>   0.0258
>  89549 default_idle                            
> 1017.6023
>   1734 ioread16                                
>  36.8936
>   1138 ioread8                                 
>  24.7391
>    974 rhine_start_tx                          
>   1.3994
>    534 __do_softirq                            
>   3.8417
>    331 handle_IRQ_event                        
>   3.2772
>    223 rhine_interrupt                         
>   0.0739
>    222 memset                                  
>   7.9286
>    194 nf_iterate                              
>   1.5520
>    140 local_bh_enable                         
>   1.0769
>     99 __kmalloc                               
>   1.0532
>     92 net_rx_action                           
>   0.2000
>     85 kfree                                   
>   0.9884
>     82 skb_release_data                        
>   0.6406
>     77 csum_partial_copy_generic               
>   0.3105
>     73 ip_push_pending_frames                  
>   0.0681
>     71 __alloc_skb                             
>   0.2898
>     69 kmem_cache_free                         
>   1.3529
>     66 kmem_cache_alloc                        
>   1.3750
>     62 csum_partial                            
>   0.2153
>     61 rt_hash_code                            
>   0.4959
>     61 ip_append_data                          
>   0.0253
>     60 netif_receive_skb                       
>   0.0516
>     58 ip_rcv                                  
>   0.0471
>     58 ip_local_deliver                        
>   0.0854
>     58 eth_type_trans                          
>   0.2489
>     55 ip_output                               
>   0.0957
>     52 icmp_reply                              
>   0.1187
> 
Thats a pretty crappy controller you have in with
that shiny P4...

I'm not sure that they want the tools to work.
They'll just call you a troll and go on
developing unnecessary things like NAPI because
they're still using controllers designed by DEC
(remember them?) back in the stone ages. 

Yet I regularly encounter people using cheap NICs
with expensive cpus on network-intensive
applications. But you'd think one or two people
would have a clue.

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
