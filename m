Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276229AbRI1SjI>; Fri, 28 Sep 2001 14:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276232AbRI1Si7>; Fri, 28 Sep 2001 14:38:59 -0400
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:58046 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S276229AbRI1Sis>; Fri, 28 Sep 2001 14:38:48 -0400
Date: Fri, 28 Sep 2001 11:39:14 -0700
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-ID: <20010928113914.B23101@helen.CS.Berkeley.EDU>
In-Reply-To: <200109281704.VAA04444@ms2.inr.ac.ru> <Pine.LNX.4.33L.0109281420180.26495-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0109281420180.26495-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Sep 28, 2001 at 02:21:07PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rik van Riel (riel@conectiva.com.br):
> On Fri, 28 Sep 2001 kuznet@ms2.inr.ac.ru wrote:
> 
> > Please, explain who exactly obtains an advantage of looping.
> > net_rx_action()? Do you see drops in backlog?
> 
> > net_tx_action()? It does not look critical.
> 
> Then how would you explain the 10% speed difference
> Ben and others have seen with gigabit ethernet ?

Could this possibly be due to I-cache improvements?  If the same 
interrupt handling code is being run 10 times at once you should
expect an improvement of that kind.

-josh
