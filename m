Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263115AbSJGPsM>; Mon, 7 Oct 2002 11:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbSJGPsM>; Mon, 7 Oct 2002 11:48:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:64189 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263115AbSJGPsK>;
	Mon, 7 Oct 2002 11:48:10 -0400
Message-ID: <3DA1ADBB.7070804@us.ibm.com>
Date: Mon, 07 Oct 2002 08:52:27 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Philipp Steinkrueger <kernel@cyberraum.de>, linux-kernel@vger.kernel.org,
       linux-admin@vger.kernel.org
Subject: Re: Memory Problem
References: <Pine.LNX.4.44L.0210071218390.22735-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Mon, 7 Oct 2002, Philipp Steinkrueger wrote:
> 
> 
>>The Problem appears with the mysql database server. here is the error
>>message:
>>
>>Can't create a new thread (errno 11). If you are not out of available
>>memory, you can consult the manual for a possible OS-dependent bug
> 
> 
>>2) what else does the kernel do when a programm spawns a new thread ? if
>>memory is not the problem, what else could go wrong when creating a
>>thread ?
> 
> 2) memory fragmentation, there is no area of 2 contiguous free pages

If you're running current 2.5, you can check /proc/buddyinfo to detect 
fragmentation.  If there are any non-zero numbers in columns after the 
first one in ZONE_NORMAL or ZONE_DMA, you should be all right

-- 
Dave Hansen
haveblue@us.ibm.com

