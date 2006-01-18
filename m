Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWARKt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWARKt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWARKt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:49:28 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:57771 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964887AbWARKt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:49:27 -0500
Message-ID: <43CE1E52.3030907@aitel.hist.no>
Date: Wed, 18 Jan 2006 11:54:10 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cynbe ru Taren <cynbe@muq.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
In-Reply-To: <E1EywcM-0004Oz-IE@laurel.muq.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cynbe ru Taren wrote:

>Just in case the RAID5 maintainers aren't aware of it:
>
>The current Linux kernel RAID5 implementation is just
>too fragile to be used for most of the applications
>where it would be most useful.
>
>In principle, RAID5 should allow construction of a
>disk-based store which is considerably MORE reliable
>than any individual drive.
>
>In my experience, at least, using Linux RAID5 results
>in a disk storage system which is considerably LESS
>reliable than the underlying drives.
>
>What happens repeatedly, at least in my experience over
>a variety of boxes running a variety of 2.4 and 2.6
>Linux kernel releases, is that any transient I/O problem
>results in a critical mass of RAID5 drives being marked
>'failed', 
>
What kind of "transient io error" would that be?
That is not supposed to happen regularly. . .

You do replace failed drives immediately?  Allowing
systems to run "for a while" in degraded mode is
surely a recipe for disaster.  Degraded mode
has no safety at all, it is just raid-0 with a performance
overhead added in. :-/

Having hot spares is a nice way of replacing the failed
drive quickly.

>at which point there is no longer any supported
>way of retrieving the data on the RAID5 device, even
>though the underlying drives are all fine, and the underlying
>data on those drives almost certainly intact.
>  
>
As other have showed - "mdadm" can reassemble your
broken raid - and it'll work well in those cases where
the underlying drives indeed are ok.  It will fail
spectacularly if you have a real double fault though,
but then nothing short of raid-6 can save you.


Helge Hafting

