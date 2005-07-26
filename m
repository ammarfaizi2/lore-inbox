Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVGZI2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVGZI2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVGZIWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:22:02 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23249 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261857AbVGZIVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:21:18 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 udev/hotplug use memory after free 
In-reply-to: Your message of "Mon, 25 Jul 2005 15:01:19 MST."
             <20050725150119.1c2714f3.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jul 2005 18:21:10 +1000
Message-ID: <24487.1122366070@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005 15:01:19 -0700, 
Andrew Morton <akpm@osdl.org> wrote:
>Keith Owens <kaos@sgi.com> wrote:
>>
>> 2.6.13-rc3 + kdb (which does not touch udev/hotplug) on IA64 (Altix).
>>  gcc version 3.3.3 (SuSE Linux).  Compiled with DEBUG_SLAB,
>>  DEBUG_PREEMPT, DEBUG_SPINLOCK, DEBUG_SPINLOCK_SLEEP, DEBUG_KOBJECT.
>> 
>>  There is a use after free somewhere above class_device_attr_show.
>
>Can we obtain a backtrace for this one, Keith?  The function itself is
>pretty innocuous and is used by many callers.  I'd be suspectng a bug in
>the caller.

I no longer have the backtrace.  This 2.6.13-rc3 system has been booted
50+ times (ia64 MCA testing) and only once did it break.  If it recurs, I'll
do some more digging.

