Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUCPI2C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbUCPI2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:28:02 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:6382 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263540AbUCPI17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:27:59 -0500
Message-ID: <4056B0E4.3090004@cyberone.com.au>
Date: Tue, 16 Mar 2004 18:46:44 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Higdon <jeremy@sgi.com>
CC: linux-kernel@vger.kernel.org, jbarnes@sgi.com, axboe@suse.de
Subject: Re: [PATCH] per-backing dev unplugging #2
References: <20040316052256.GA647970@sgi.com> <4056A062.6040203@cyberone.com.au> <20040316072046.GA636090@sgi.com>
In-Reply-To: <20040316072046.GA636090@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeremy Higdon wrote:

>On Tue, Mar 16, 2004 at 05:36:18PM +1100, Nick Piggin wrote:
>
>>
>>Jeremy Higdon wrote:
>>
>>
>>>My tests were on an 8 CPU x 1300 MHz Altix with 64 disks.
>>>
>>>
>>>
>>Nice - so if you had enough IO capacity to saturate the CPUs it
>>might come close to a 4x improvement - and this sounds like one
>>of your baby systems?
>>
>
>Baby by cpu count, mid size by I/O capability.  Extrapolations of
>this sort are fraught with peril.  However, it is conceivable that
>we would end up with 4X the IOPS.
>
>

Well, it is more than 2x! What does a profile look like after
the patch, I wonder?

>>I wonder why nobody's complained about this before?
>>
>
>Well, some of us have, but probably not very loudly.  I had
>naively believed that the global unplug was gone in 2.6.
>
>

I wasn't talking about SGI in particular, I just remember
people being very worried about making sure we can support
*thousands* of queues quite a while back.

Anyway, it's done now. And Jens' patch turned out to be pretty
simple and probably makes the code cleaner, anyway.

