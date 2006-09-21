Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWIURii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWIURii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 13:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWIURih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 13:38:37 -0400
Received: from brick.kernel.dk ([62.242.22.158]:7019 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751261AbWIURih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 13:38:37 -0400
Date: Thu, 21 Sep 2006 19:43:11 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Lyon <andrew.lyon@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: JMicron 20360/20363 AHCI Controller much slower with 2.6.18
Message-ID: <20060921174310.GK24362@kernel.dk>
References: <f4527be0609210104p3c6c4933ke77d8372f6dd3848@mail.gmail.com> <4512C54B.9060705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4512C54B.9060705@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22 2006, Tejun Heo wrote:
> Andrew Lyon wrote:
> >Hi,
> >
> >I have a Gigabyte GA_965P_DS3 with Core 2 Duo CPU, wd raptor connected
> >to onboard JMicron 20360/20363 AHCI Controller, with 2.6.18 the drive
> >is very slow:
> >
> >beast ~ # uname -a
> >Linux beast 2.6.18 #1 SMP Wed Sep 20 15:04:24 BST 2006 i686 Intel(R) 
> >Core(TM)2 C
> >PU          6600  @ 2.40GHz GNU/Linux
> >beast ~ # hdparm -t /dev/sda
> >
> >/dev/sda:
> >Timing buffered disk reads:  100 MB in  3.02 seconds =  33.10 MB/sec
> 
> Which IO scheduler are you using?  If you're using anticipatory or cfq, 
> can you try deadline?

It would also be nice to have a way to turn NCQ off, btw, just to rule
that out as well.

-- 
Jens Axboe

