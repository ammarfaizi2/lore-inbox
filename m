Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTFXToP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 15:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFXToP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 15:44:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:54198 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261454AbTFXToL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 15:44:11 -0400
Subject: Re: Large backwards time steps panic 2.5.73
From: john stultz <johnstul@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1056472020.2085.81.camel@mulgrave>
References: <1056472020.2085.81.camel@mulgrave>
Content-Type: text/plain
Organization: 
Message-Id: <1056484203.1033.192.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Jun 2003 12:50:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-24 at 09:26, James Bottomley wrote:
> I've got one of those fun machines with a failing bios batter that
> always boots up with the BIOS clock about a year into the future.
> 
> 2.5.73 always panics around the time ntpdate sets the clock back to its
> normal value with:
> 
> kernel BUG at kernel/timer.c:377!
> Kernel addresses on the stack:

[snip]

> Reverting the patch
> 
> ChangeSet 1.1348.6.16 2003/06/20 22:13:39 akpm@digeo.com
>   [PATCH] revert adjtimex changes
>   
>   From: John Stultz, George Anzinger, Eric Piel
>  
> Fixes the problem for me.
> 
> The above trace is from a HP PA-RISC machine running 2.5.73-pa1.

Hmm. Odd. What is the HZ frequency on this machine? 

thanks
-john


