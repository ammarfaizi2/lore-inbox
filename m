Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbUJYU3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbUJYU3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUJYU2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:28:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261296AbUJYUQM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:16:12 -0400
Date: Mon, 25 Oct 2004 16:15:34 -0400 (EDT)
From: linux-os <root@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Corey Minyard <minyard@acm.org>
cc: Andi Kleen <ak@suse.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels
In-Reply-To: <417D5903.6090106@acm.org>
Message-ID: <Pine.LNX.4.61.0410251612380.3949@chaos.analogic.com>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel>
 <p73u0sik2fa.fsf@verdi.suse.de> <417D5903.6090106@acm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Corey Minyard wrote:

> According to the comments in 2.4, this code causes the NMI to be re-asserted 
> if another NMI occurred while the NMI handler was running.  I have no idea 
> how twiddling with these CMOS registers causes this to happen, but that is 
> supposed to be the intent.  I don't think it has anything to do with delays.
>
> I would like to know what this code really does before removing it.
>
> -Corey
>
> Andi Kleen wrote:
>

NMI is supposed to be turned OFF if the high-bit in the index
register is set. It is turned back ON if it is reset.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
