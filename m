Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275354AbTHSFeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275464AbTHSFeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:34:14 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:43014 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S275354AbTHSFeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:34:11 -0400
Message-Id: <200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Anthony R." <russo.lutions@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Date: Tue, 19 Aug 2003 08:33:49 +0300
X-Mailer: KMail [version 1.3.2]
References: <3F41AA15.1020802@verizon.net>
In-Reply-To: <3F41AA15.1020802@verizon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 August 2003 07:39, Anthony R. wrote:
> I would like to tune my kernel not to use as much memory for cache
> as it currently does. I have 2GB RAM, but when I am running one program
> that accesses a lot of files on my disk (like rsync), that program uses
> most of the cache, and other programs wind up swapping out. I'd prefer to
> have just rsync run slower because less of its data is cached, rather
> than have
> all my other programs run more slowly. rsync is not allocating memory,
> but the kernel is caching it at the expense of other programs.

There was a discussion (and patches) in the middle of 2.5 series
about O_STREAMING open flag which mean "do not aggressively cache
this file". Targeted at MP3/video playing, copying large files and such.

I don't know whether it actually was merged. If it was,
your program can use it.
 
> With 2GB on a system, I should never page out, but I consistently do and I
> need to tune the kernel to avoid that. Cache usage is around 1.4 GB!

So why did you configured your system to have huge swap?
That's rather contradictory setup ;)

> I never had this problem with earlier kernels. I've read a lot of comments
> where so-called experts poo-poo this problem, but it is real and
> repeatable and I am
> ready to take matters into my own hands to fix it. I am told the cache
> is replaced when
> another program needs more memory, so it shouldn't swap, but that is not
> the
> behaviour I am seeing.
> 
> Can anyone help point me in the right direction?

I'd say stop allocating insane amounts of swap.
Frankly, with 2G you may run without swap at all.
--
vda
