Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWABHTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWABHTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 02:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWABHTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 02:19:24 -0500
Received: from main.gmane.org ([80.91.229.2]:8861 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932325AbWABHTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 02:19:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Howto set kernel makefile to use particular gcc
Date: Mon, 02 Jan 2006 16:19:10 +0900
Message-ID: <dpak5e$tip$1@sea.gmane.org>
References: <3AEC1E10243A314391FE9C01CD65429B2239C2@mail.esn.co.in> <200512301624.24229.chriswhite@gentoo.org> <dp89d4$u0i$1@sea.gmane.org> <20060101120057.GS3811@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <20060101120057.GS3811@stusta.de>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Jan 01, 2006 at 07:03:15PM +0900, Kalin KOZHUHAROV wrote:
> 
>>As I just stumbeled into a similar problem, I am going to ask here.
>>
>>I know the "trick" of `make -j8 CC=distcc` and I always use it. But is there a way to hardwire
>>"CC=distcc" insie the Makefile? Just setting it there does not help it seems.
> 
> 
> Setting it somewhere at the top of the Makefile doesn't help since the 
> Makefile sets it itself later overriding your setting.
> 
> The Makefile contains the line
>   CC              = $(CROSS_COMPILE)gcc
> 
> Change this line to
>   CC              = $(CROSS_COMPILE)distcc

Thanks! That works perfect, now rebuilding the 2.6.14.5 series :-)

Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

