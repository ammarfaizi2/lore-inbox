Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264974AbUEYRCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbUEYRCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbUEYRCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:02:06 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:56459 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S264974AbUEYRAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:00:24 -0400
Date: Tue, 25 May 2004 11:02:14 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
Message-ID: <20040525170214.GA26785@bounceswoosh.org>
Mail-Followup-To: Giuliano Pochini <pochini@denise.shiny.it>,
	"Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
	Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
References: <BAY18-F105X7rz6AvEm0002622f@hotmail.com> <200405151506.20765.bzolnier@elka.pw.edu.pl> <c8bdqv$lib$1@gatekeeper.tmr.com> <20040524024136.GB2502@zero> <20040524171656.GA19026@bounceswoosh.org> <Pine.LNX.4.58.0405251101240.1197@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405251101240.1197@denise.shiny.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25 at 11:05, Giuliano Pochini wrote:
>
>
>On Mon, 24 May 2004, Eric D. Mudama wrote:
>
>> Picture a nice fast drive doing 100 writes/second to the media... if
>> you give it over 200 writes at a time, it'll occupy your 2 seconds.
>> Newer drives with 8MB or larger buffers are certainly capable of
>> caching a lot more than 200 writes...
>
>Quite unlikely. Usually disks have a big cache but it can hold a very
>limited number of blocks. 8MB of cache is probably divided in 8 blocks
>of 1MB each.

Sorry, but that isn't true, unless some company is just plain stupid.

Everyone has different metrics for cache granularity based on their
cache architecture, but I can assure you that 8x 1MB segments is off
by 1-2 orders of magnitude, and has been for years.

In practice, depending on the workload, there may appear to only be 8
active segments as drives today can merge cache segments or other
similar things (architectually dependant), but the worst-case (best
case?) is significantly more.

--eric



-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

