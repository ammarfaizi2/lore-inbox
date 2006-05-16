Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWEPVAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWEPVAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWEPVAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:00:17 -0400
Received: from relay03.pair.com ([209.68.5.17]:53772 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1750798AbWEPVAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:00:15 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 16 May 2006 16:00:14 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Help: strange messages from kernel on IA64 platform
In-Reply-To: <890BF3111FB9484E9526987D912B261901BD84@NAMAIL3.ad.lsil.com>
Message-ID: <Pine.LNX.4.64.0605161558200.32181@turbotaz.ourhouse>
References: <890BF3111FB9484E9526987D912B261901BD84@NAMAIL3.ad.lsil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, Ju, Seokmann wrote:

> Hi,
>
> During communication in between application and megaraid driver via
> IOCTL, the system displays messages which are not easy to track down.
> Following is one of the messages and same messages with different values
> are poping up regularly.
> ---
> Kernel unaligned access to 0xe00000007f3d80dc ip=0xa0000002000373b1
> ---
>
> I understand the kernel is complaining about the address which is not
> aligned and, found the message is coming from function
> 'ia64_handle_unaligned()' in the arch/ia64/kernel/unaligned.c.
> But, I couldn't find who is calling this function and further details of
> reasons.
>
> Where should I start to figure out it?

It's a trap, which means the CPU is effectively calling that function. My 
best suggestion is to figure out what data is at 0xe00000007f3d80dc and 
what instructions are at 0xa0000002000373b1.

> Thank you,
>
> Seokmann

Thanks,
Chase
