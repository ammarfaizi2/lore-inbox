Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbUK3V2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbUK3V2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUK3V2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:28:09 -0500
Received: from alog0079.analogic.com ([208.224.220.94]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262320AbUK3V1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:27:52 -0500
Date: Tue, 30 Nov 2004 16:26:52 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
Subject: RE: Walking all the physical memory in an x86 system
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C205805721@azsmsx406>
Message-ID: <Pine.LNX.4.61.0411301625280.4618@chaos.analogic.com>
References: <C863B68032DED14E8EBA9F71EB8FE4C205805721@azsmsx406>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, Hanson, Jonathan M wrote:

>
>
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan Engelhardt
> Sent: Tuesday, November 30, 2004 9:10 AM
> To: Hanson, Jonathan M
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: Walking all the physical memory in an x86 system
>
>>> dd_rescue /dev/mem copyofmem
>>
>> I'm not sure what dd_rescue is as I've never heard of
>> it. However, I don't think such an operation can be done from userspace
>> because I need the physical addresses of memory not the virtual ones.
>
> /dev/mem *is* physical.
>
> [Jon M. Hanson] I can read /dev/mem from a userspace application as root
> with no problems and print out what it sees. However, things are not so
> simple from a kernel module as I just can't call open() and read() on
> /dev/mem because no such functions are exported from the kernel. Is
> there a way to read the contents of /dev/mem from a kernel module?
>

You just read it directly (hint ioremap) ......


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
