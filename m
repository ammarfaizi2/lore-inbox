Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVEJHwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVEJHwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 03:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVEJHwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 03:52:50 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:45255 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261570AbVEJHwr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 03:52:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lrjlmmEm2a1WVF2hySFD/KHcIEStPkDi7J5NoR2pIHBn7RgCZVgpnDW8CXZhHCeqoz6xSJnRMd3IWDdMCQmgxgqyL5t5q5jwgqpmJN3EeEm/D/+GYQ27mhtOccmuSpZHZslsaW6iKqgAuzpPtDOUn0PIs7H3+sYRybfTBL6putk=
Message-ID: <2cd57c90050510005247d84d9d@mail.gmail.com>
Date: Tue, 10 May 2005 15:52:47 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: "A.M. Fradley" <u2amf@csc.liv.ac.uk>
Subject: Re: An attempt to improve the swap tokening:
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <1115607333.427ed12531f96@cgi.server.csc.liv.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1113667425.426137617423a@cgi.server.csc.liv.ac.uk>
	 <Pine.LNX.4.61L.0504271322280.13884@imladris.surriel.com>
	 <1114676760.42709e18b0227@cgi.server.csc.liv.ac.uk>
	 <Pine.LNX.4.61L.0504281549130.26165@imladris.surriel.com>
	 <1115052944.42765b90ba515@cgi.server.csc.liv.ac.uk>
	 <Pine.LNX.4.61L.0505021638110.31547@imladris.surriel.com>
	 <1115101782.42771a56e4b81@cgi.server.csc.liv.ac.uk>
	 <Pine.LNX.4.61L.0505031136470.2760@imladris.surriel.com>
	 <1115216727.4278db57baad5@cgi.server.csc.liv.ac.uk>
	 <1115607333.427ed12531f96@cgi.server.csc.liv.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/05, A.M. Fradley <u2amf@csc.liv.ac.uk> wrote:
> I'd been trying to reduce the amount of page swapping in order to improve the
> kernels behaviour during thrashing as a project for my course.  I made this
> after Arjan van de Ven and Rik van Riel suggested I looked into the swap
> tokening mechanism as part of my research.  I came up with a function to
> measure the swap rate and then to activate/deactivate the token mechanism
> depending on how much swapping was being done overall.  I think the statistics
> I added to the thrash.c file could help it decide how to behave but I'm unsure
> how best to use them to do that.
> 
> I've tried testing it a few different ways
> but none of them seem to make any difference.  I think this is because of my
> tests though.  I made one program that allocates a linked list, until it is
> 128MB long, then once it's done that, it should swap in the oldest page in
> order to free the memory and then swap the newest one back in to edit the
> pointer to the next node then continue for 2 mins.  Then to test how much
> progress is made
> during the thrashing, I've been running a simple counter program that stops
> after minute and I've been comparing the max number reached for the different
> attempts I've been making with the kernel.  The program for causing thrashing
> at least makes it swap pages because I can watch the memory and swap fill up in
> system monitor.  Running the program to cause thrashing seems to work because
> the kernel begins reporting high swap rates when the list reaches the target
> length.
> 
> Does anyone know any programs that are designed to test this type of
> thing or any comments on the code that I wrote?  I'm still new at this, so I've
> probably misunderstood/left out some things.  The updateSwapRate() fuction is
> called at the end of scheduler_tick().  That could probably go somewhere
> better.  Also, I wasn't sure if changing the value of
> swap_token_default_timeout was all I needed to do to reactivate the tokening as
> it was disabled in 2.6.11 that I'm working with.
> 


Wouldn't it be better shown in patch form?


-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
