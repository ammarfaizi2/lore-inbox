Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWG3S2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWG3S2s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWG3S2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:28:48 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:62226 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932372AbWG3S2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:28:47 -0400
Message-ID: <44CCFA5A.2030605@argo.co.il>
Date: Sun, 30 Jul 2006 21:28:42 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
References: <Pine.LNX.4.61.0607302018110.25626@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607302018110.25626@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2006 18:28:45.0997 (UTC) FILETIME=[FE3E4DD0:01C6B405]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>
> > kernel_fpu_begin();
> > c = d * 3.14;
> > kernel_fpu_end();
>
> static inline void kernel_fpu_begin() {
>     ...
>     preempt_disable();
>     ...
> }
>
Is the kernel allowed to clobber userspace's sse registers?

What about interrupt code?

xor.h at least appears to save the sse state before use.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

