Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVDKMkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVDKMkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 08:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVDKMkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 08:40:10 -0400
Received: from alog0400.analogic.com ([208.224.222.176]:53412 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261557AbVDKMkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 08:40:03 -0400
Date: Mon, 11 Apr 2005 08:38:54 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: jayalk@intworks.biz, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH 2.6.11.7 1/1] x86 reboot: Add reboot fixup for gx1/cs5530a
In-Reply-To: <425A6AA1.3050601@zytor.com>
Message-ID: <Pine.LNX.4.61.0504110836420.24360@chaos.analogic.com>
References: <200504110702.j3B72hau000852@intworks.biz> <425A6AA1.3050601@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2005, H. Peter Anvin wrote:

> jayalk@intworks.biz wrote:
>> Hi Riley, Dave, Peter, i386 boot/workaround maintainers,
>>
>> I'm resending this patch (from March 28).
>>
>> This patch incorporates the suggestions from the previous thread and also
>> switches to using pci_get_device since pci_find_device is deprecated, and
>> made some of the variables static.
>>
>> Please let me know if it's okay.
>>
>
>> +#define mach_reboot_fixups(x) do {} while (0)
>
> As I stated last time, this should be:
>
> #define mach_reboot_fixup(x)	((void)(x))
>
> ... to preserve side effects, and be expression-like.
>
> 	-hpa

Shouldn't it just be:

#define mach_reboot_fixup(x)
                               |___ Nothing here.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
