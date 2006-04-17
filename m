Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWDQQqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWDQQqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWDQQqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:46:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750734AbWDQQqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:46:36 -0400
Date: Mon, 17 Apr 2006 09:46:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       matt.keenan@btinternet.com
Subject: Re: want to randomly drop packets based on percent
Message-ID: <20060417094634.7191fea5@localhost.localdomain>
In-Reply-To: <4444171B.90507@cmu.edu>
References: <444345F9.4090100@cmu.edu>
	<20060417091915.67e28361@localhost.localdomain>
	<4444171B.90507@cmu.edu>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006 18:30:51 -0400
George Nychis <gnychis@cmu.edu> wrote:

> 
> 
> Stephen Hemminger wrote:
> 
> >On Mon, 17 Apr 2006 03:38:33 -0400
> >George Nychis <gnychis@cmu.edu> wrote:
> >
> >  
> >
> >>Hey,
> >>
> >>I'm using the 2.4.32 kernel with madwifi and iproute2 version 
> >>2-2.6.16-060323.tar.gz
> >>
> >>I wanted to insert artificial packet loss based on a percent so i found:
> >>network emulab qdisc could do it, so i compiled support into the kernel 
> >>and tried:
> >>tc qdisc change dev eth0 root netem loss .1%
             ^^^^^^

You need to do add not change. Add will set the queue discipline
to netem (default is pfifo_fast).  Change is for changing netem parameters
after it is loaded.
