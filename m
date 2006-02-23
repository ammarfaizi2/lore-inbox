Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWBWROd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWBWROd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWBWROd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:14:33 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:31934 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751441AbWBWROc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:14:32 -0500
Date: Thu, 23 Feb 2006 18:14:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Mapping to 0x0
In-Reply-To: <Pine.LNX.4.61.0602220920060.10177@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0602231811320.1279@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0602221504120.11432@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0602220920060.10177@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> int main(void) {
>>    int fd   = open("badcode.bin", O_RDONLY);
>      int fd   = open("/dev/mem", O_RDWR);
>
>>    mmap(NULL, 4096, PROT_READ | PROT_EXEC, MAP_FIXED, fd, 0);
>> }
>>
>No. In your demo code, page 0 gets memory-mapped into user space.
>This allows user-mode code to access the first page of memory
>and even read/write offset 0, still in user mode, with the
>root privs that allowed you access to that page in the
>first place.

Only root can map to 0x0?

>Everything you do, is still in user-mode.
>You just own some physical memory that the kernel didn't
>care about anyway.

So you can't accidentally call a place in userspace from kernel context?
(Including the case where set_fs(USER_DS) was used.)


Jan Engelhardt
-- 
