Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290523AbSA3T7h>; Wed, 30 Jan 2002 14:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290528AbSA3T7V>; Wed, 30 Jan 2002 14:59:21 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:63206 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S290521AbSA3T7J>;
	Wed, 30 Jan 2002 14:59:09 -0500
Date: Wed, 30 Jan 2002 20:58:39 +0100
From: David Weinehall <tao@acc.umu.se>
To: Kent E Yoder <yoder1@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
Message-ID: <20020130205839.S1735@khan.acc.umu.se>
In-Reply-To: <OF0323731B.AAE52C6B-ON85256B51.005748CD@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF0323731B.AAE52C6B-ON85256B51.005748CD@raleigh.ibm.com>; from yoder1@us.ibm.com on Wed, Jan 30, 2002 at 01:27:29PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:27:29PM -0600, Kent E Yoder wrote:
>   I think the delays in the driver *were* just working around PCI posting 
> effects.  I tested by removing all the delays and instead putting 
> something like:
>         writew(val, addr);
>         (void) read(addr);
> 
> instead, to flush the PCI cache.  Things seem to be happy. 
> 
> Is this the best way to make sure the PCI cache is flushed for writes that 
> need to happen immediately?  I don't see many other drivers doing it...

Wouldn't creating a flush_and_writew() or similar be an idea here?


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
