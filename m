Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWAJIft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWAJIft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 03:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWAJIft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 03:35:49 -0500
Received: from relay01.pair.com ([209.68.5.15]:44562 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932103AbWAJIfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 03:35:48 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: State of the Union: Wireless
Date: Tue, 10 Jan 2006 02:36:01 -0600
User-Agent: KMail/1.9
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, acx100-devel@lists.sourceforge.net
References: <20060106042218.GA18974@havoc.gtf.org> <200601100839.26052.vda@ilport.com.ua>
In-Reply-To: <200601100839.26052.vda@ilport.com.ua>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100236.01287.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 00:39, Denis Vlasenko wrote:
> How are we going to find out which stack is best and which stack
> we should concentrate our efforts on? In an absense of wifi maintainer,
> maybe we should throw _all stacks_ (currently two) into the mainline,
> and evolution will find the best one. Yes, it would be a bit ugly
> at first, but I hope it will speed up evolution a lot.
>
> Let current stack sit in include/net/ieee80211*.h and net/ieee80211/*,
> add dcape one into include/net/wlan*.h and net/wlan/*
> (s/wlan/dscape/ or whatever)
>
> We can even give Devicescape folks blanket permissions to
> maintain their stack in include/net/wlan*.h and net/wlan/*.
> Maybe they can act as a wifi maintainer long term.
>
> Existing drivers won't need to closely track every change
> in dscape stack. If dscape will survive, old drivers can be
> converted to it gradually. If not, just dike it out.

I don't like the idea of maintaining two of anything. What if I have two 
wireless interfaces, each using a different stack?

Performance--,
Kernel size++

I get that it's hard to get everyone to agree on one stack or another, but we 
need to make the decision now because the longer we don't have a decision 
made (this includes maintaining two in-tree stacks) the longer it's going to 
take us to have serious / robust / reliable / consistent wireless support.

I know basically nothing about 802.11, but it seems to me that what should 
happen is that if there is sufficient motivation to boot ieee80211 in favor 
of DeviceScape, someone should cook up the patches. 

Besides, assume we did bless two stacks. Every new driver / driver that wanted 
to go mainline would choose one or another (it's already clear that people 
disagree). Thus we end up with *more* work to do in order to decide one way 
or another (since we have to partially break & fully port all the drivers 
from one stack to another). 

There's incompatibility all over this wireless landscape. The best way to deal 
with it is to make all the big hard decisions now - say "this is the way it's 
going to be" and work from there. We can always undo mistakes later, but 
we'll never get to that point if we don't start moving in one direction 
instead of ten.

> --
> vda
> -

Cheers,
Chase
