Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVBPV0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVBPV0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVBPV0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:26:40 -0500
Received: from alog0364.analogic.com ([208.224.222.140]:5760 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262086AbVBPV0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:26:36 -0500
Date: Wed, 16 Feb 2005 16:25:00 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: govind raj <agovinda04@hotmail.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Customized 2.6.10 kernel on a Compact Flash
In-Reply-To: <BAY10-F2463631423ADD0786503EAD66C0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0502161619330.12007@chaos.analogic.com>
References: <BAY10-F2463631423ADD0786503EAD66C0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005, govind raj wrote:

> Hi all,
>
> We are trying to build a customized kernel image from the stable 2.6.10 
> kernel release (in kernel.org). We have not applied any kernel patches on 
> this released version. We are trying to boot this custom image onto a compact 
> flash (from Toshiba) in a embedded board (AMD processor with 64 MB RAM). 
> While the kernel is coming up during the boot process, it panics and the 
> console output is as follows:
>
[SNIPPED...]


> Freeing unused kernel memory: 128k freed
> Kernel panic - not syncing: Attempted to kill init!

This message occurs when init or something you substituted
for init 'returns' to the kernel!

Everything is fine up to that point. Perhaps you don't have
init's correct C-runtime library?

You can make an init program with a main(), printf() and pause(),
statically-linked. That would get you started.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
