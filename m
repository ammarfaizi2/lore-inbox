Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268021AbRHJN3P>; Fri, 10 Aug 2001 09:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbRHJN3F>; Fri, 10 Aug 2001 09:29:05 -0400
Received: from mail.mesatop.com ([208.164.122.9]:7175 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S267992AbRHJN2r>;
	Fri, 10 Aug 2001 09:28:47 -0400
Message-Id: <200108101328.f7ADSue26118@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: torvalds@transmeta.com
Subject: Re: Some dbench 32 results for 2.4.8-pre8, 2.4.7-ac10, and 2.4.7
Date: Fri, 10 Aug 2001 07:26:47 -0600
X-Mailer: KMail [version 1.2.2]
In-Reply-To: <200108100502.f7A52Ve23324@thor.mesatop.com>
In-Reply-To: <200108100502.f7A52Ve23324@thor.mesatop.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>Does the numbers change if you do something like
>
>	killall -STOP kupdated
>	echo 80 64 64 256 500 6000 90 > /proc/sys/vm/bdflush
>
>to make it less eager to write stuff out? (That just stops the
>every-five-second flush, and makes the dirty balancing numbers be 80/90%
>instead of the default 30/60%)
>
>In particular, the dirty balancing worked really badly before, and was
>just fixed.  I suspect that the bdflush numbers were tuned with the
>badly-working case, and they might be a bit too aggressive for dbench
>these days.. 

Sorry Linus for the late reply, but I went to bed just before your message.
I re-ran dbench 32 with the settings above.  Here are the results:
(Same conditions as in the previous tests otherwise).  Now, off to my day job.
 
Run #1 Throughput 12.7943 MB/sec    2.4.8-pre8
Run #2 Throughput 12.667 MB/sec     2.4.8-pre8
Run #3 Throughput 12.7091 MB/sec    2.4.8-pre8
 
Run #4 Throughput 13.7765 MB/sec    2.4.7
Run #5 Throughput 13.9632 MB/sec    2.4.7
Run #6 Throughput 13.9318 MB/sec    2.4.7

Steven

