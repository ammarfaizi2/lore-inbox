Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316429AbSEOQXT>; Wed, 15 May 2002 12:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316431AbSEOQXS>; Wed, 15 May 2002 12:23:18 -0400
Received: from holomorphy.com ([66.224.33.161]:22690 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316429AbSEOQXR>;
	Wed, 15 May 2002 12:23:17 -0400
Date: Wed, 15 May 2002 09:21:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
Message-ID: <20020515162116.GE27957@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <200205151514.g4FFEmY13920@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44L.0205151310130.9490-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Denis Vlasenko wrote:
>> I think two patches for same kernel piece at the same time is
>> too many. Go ahead and code this if you want.

On Wed, May 15, 2002 at 01:13:33PM -0300, Rik van Riel wrote:
> OK, here it is.   Changes against yesterday's patch:
> 1) make sure idle time can never go backwards by incrementing
>    the idle time in the timer interrupt too (surely we can
>    take this overhead if we're idle anyway ;))
> 2) get_request_wait also raises nr_iowait_tasks (thanks akpm)
> This patch is against the latest 2.5 kernel from bk and
> pretty much untested. If you have the time, please test
> it and let me know if it works.

I'll take it for a spin on my 8-way HT box; I can remove enough of
the non-compiling device subsystems to get test boots & runs in there.


Cheers,
Bill
