Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVECJA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVECJA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 05:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVECJA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 05:00:56 -0400
Received: from tornado.reub.net ([60.234.136.108]:15072 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261429AbVECJAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 05:00:50 -0400
Message-ID: <42773DC0.4050803@reub.net>
Date: Tue, 03 May 2005 21:00:48 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050501)
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm1
References: <fa.gbejpad.1vj8f9r@ifi.uio.no>
In-Reply-To: <fa.gbejpad.1vj8f9r@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm1/
> 
> - There's still a bug in the new timer code.  If you think you hit it,
>   please revert 
> 
> 	timers-fixes-improvements-fix.patch			then
> 	timers-fixes-improvements-smp_processor_id-fix.patch	then
> 	timers-fixes-improvements.patch
> 
>   or, better, fix the bug.

FWIW, I can reproduce this timer bug fairly consistently, by simply 
rebooting my cisco router.  That means that my linux box has no default 
gateway, and hence the networking blows up within about 30s and dies 
with a stack trace which has references to timers.

I'll back out those three patches and see if it continues, but hopefully 
my little discovery is useful to someone in terms of coming up with a 
fix....

Box is an Intel 2.8/SMP

reuben
