Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265426AbUEZKVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbUEZKVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265427AbUEZKVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:21:51 -0400
Received: from ptb-relay03.plus.net ([212.159.14.214]:38923 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S265426AbUEZKVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:21:37 -0400
Message-ID: <40B46F97.7040803@mauve.plus.com>
Date: Wed, 26 May 2004 11:21:11 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Giuliano Pochini <pochini@denise.shiny.it>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
References: <BAY18-F105X7rz6AvEm0002622f@hotmail.com> <20040524171656.GA19026@bounceswoosh.org> <Pine.LNX.4.58.0405251101240.1197@denise.shiny.it> <200405251703.43000.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405251703.43000.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 25 of May 2004 11:05, Giuliano Pochini wrote:
> 
>>On Mon, 24 May 2004, Eric D. Mudama wrote:
>>
>>>Picture a nice fast drive doing 100 writes/second to the media... if
>>>you give it over 200 writes at a time, it'll occupy your 2 seconds.
>>>Newer drives with 8MB or larger buffers are certainly capable of
>>>caching a lot more than 200 writes...
>>
>>Quite unlikely. Usually disks have a big cache but it can hold a very
>>limited number of blocks. 8MB of cache is probably divided in 8 blocks
>>of 1MB each.
> 
> 
> No.

It is indeed likely that the worst case is around 16000 writes, which if
on seperate tracks may take over 30 seconds to complete if done individually.

However, it's likely that any drive designer with a clue would allocate a
couple of journal tracks, so that the write cache and two backup copies can
be stored for replay when the drive is powered on again.

Why do I suspect that some designers don't have clue, or haven't really thought
enough about this case.
