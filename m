Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbUKEElC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbUKEElC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 23:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbUKEElB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 23:41:01 -0500
Received: from ultra7.eskimo.com ([204.122.16.70]:18957 "EHLO
	ultra7.eskimo.com") by vger.kernel.org with ESMTP id S262592AbUKEEkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 23:40:52 -0500
Date: Thu, 4 Nov 2004 20:38:31 -0800
From: Elladan <elladan@eskimo.com>
To: Tim Connors <tconnors+linuxkernel1099624161@astro.swin.edu.au>
Cc: Elladan <elladan@eskimo.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Russell Miller <rmiller@duskglow.com>,
       Doug McNaught <doug@mcnaught.org>, Jim Nelson <james4765@verizon.net>,
       DervishD <lkml@dervishd.net>, Gene Heskett <gene.heskett@verizon.net>,
       linux-kernel@vger.kernel.org, M?ns Rullg?rd <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041105043831.GD17010@eskimo.com>
References: <200411030751.39578.gene.heskett@verizon.net> <87k6t24jsr.fsf@asmodeus.mcnaught.org> <200411031733.30469.rmiller@duskglow.com> <200411040839.34350.vda@port.imtp.ilyichevsk.odessa.ua> <20041105023850.GC17010@eskimo.com> <slrn-0.9.7.4-4729-165-200411051409-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrn-0.9.7.4-4729-165-200411051409-tc@hexane.ssi.swin.edu.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 02:10:35PM +1100, Tim Connors wrote:
> Elladan <elladan@eskimo.com> said on Thu, 4 Nov 2004 18:38:50 -0800:
> > If a process is in D state and receives a SIGKILL, assume it must exit
> > within a few seconds or it's a bug, and dump as much information about
> > it as is practical...?
> 
> Of course, it's not necessarily a bug. Someone could have just kicked
> the ethernet, and so your process is stuck waiting for a read/write.

Sounds like a bug to me.  Kernel resource leak due to network activity?

-J
