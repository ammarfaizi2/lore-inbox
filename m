Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTLKFtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 00:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTLKFtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 00:49:46 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:56248 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262767AbTLKFto
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 00:49:44 -0500
Message-ID: <3FD80543.8040905@cyberone.com.au>
Date: Thu, 11 Dec 2003 16:48:51 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Raul Miller <moth@magenta.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Ed Sweetman <ed.sweetman@wmich.edu>, Donald Maner <donjr@maner.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com>
In-Reply-To: <20031211054111.GX8039@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Thu, Dec 11, 2003 at 12:33:39AM -0500, Ed Sweetman wrote:
>
>>I thought highmem wasn't necesarily needed for memory <=2GB? Highmem 
>>incurs some performance hits doesn't it and so the urge to move to it 
>>with only 2GB is not very attractive.  Anyways i'm just interested in if 
>>that's the case or not since 2GB is easy to get to these days and i had 
>>heard that highmem could be avoided passed the 1GB barrier.
>>
>
>You're probably thinking of 2:2 split patches.
>
>2:2 splits are at least technically ABI violations, which is probably
>why this isn't merged etc. Applications sensitive to it are uncommon.
>
>Yes, the SVR4 i386 ELF/ABI spec literally mandates 0xC0000000 as the
>top of the process address space.
>

At any rate, Raul, highmem shouldn't hurt your performance significantly
with the 2.6 kernel. If it does then send a note to the list.

Your other options are a different user/kernel split, or a 64-bit kernel,
both of which should have less overhead than highmem.


