Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbUKCQsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbUKCQsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUKCQsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:48:43 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:40891 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261722AbUKCQrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:47:15 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 11:47:14 -0500
User-Agent: KMail/1.7
Cc: DervishD <lkml@dervishd.net>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <yw1xis8nhtst.fsf@ford.inprovide.com> <20041103152531.GA22610@DervishD>
In-Reply-To: <20041103152531.GA22610@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411031147.14179.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 10:47:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 10:25, DervishD wrote:
>    Hi all :)
>
> * Måns Rullgård <mru@inprovide.com> dixit:
>> >> I'd tried to kill the zombie earlier but couldn't.
>> >> Isn't there some way to clean up a &^$#^#@)_ zombie?
>> >
>> > Kill the parent, is the only (portable) way.
>>
>> Perhaps not as portable, but another possible, though slightly
>> complicated, way is to ptrace the parent and force it to wait().
>
>    Or write a little program that just 'wait()'s for the specified
>PID's. That is perfectly portable IMHO. But I must admit that the
>preferred way should be killing the parent. 'init' will reap the
>children after that.

But what if there is no parent, since the system has already disposed 
of it?

There was no parent visible to kpm.  Unforch kpm also doesn't 
specificaly mark zombies as such either, so its a bit clueless in 
that regard.  Finding them is usually an exersize in stretching the 
top window out till its about 20 screens high as its always going to 
be at the bottom of the list.

If init can indeed do the cleanup, then how hard is it to have a "kill 
--total procnumber" pass that info into init and let it do its thing?

Or better yet, when X asks me if I want it gone because its not 
responding to the close button, have X do it all in one swell foop.

>    Raúl Núñez de Arenas Coronado

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
