Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVC3Qrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVC3Qrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 11:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVC3Qrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 11:47:52 -0500
Received: from alog0692.analogic.com ([208.224.223.229]:11659 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262333AbVC3Qrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 11:47:37 -0500
Date: Wed, 30 Mar 2005 11:47:18 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: krishna <krishna.c@globaledgesoft.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to debug kernel before there is no printk mechanism?
In-Reply-To: <424AD247.4080409@globaledgesoft.com>
Message-ID: <Pine.LNX.4.61.0503301134240.28049@chaos.analogic.com>
References: <424AD247.4080409@globaledgesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, krishna wrote:

> Hi all,
>
> How can one debug kernel before there is no printk mechanism in kernel.
>
> Regards,
> Krishna Chaitanya

Write directly to screen memory at 0x000b8000, or write to the
RS-232C UART while polling the TX buf empty bit, or just write
bits that mean something to you out the printer port.

Screen - memory is 16-bit words with the high-word being
an attibute byte. FYI 0x07 is a good B&W byte. You can
initialize a pointer to it as:

unsigned short *screen = 0xc00b8000; Since low memory
is always mapped, the above cheat will work. The 0xc0000000
is PAGE_OFFSET.

An early '486 was brought up into a 32-bit protected-mode
(non linux) operating system using these debugging methods.
The first time I got to see some symbol written to the
screen in protected-mode marked the start of a week-end-
long party. Have fun!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
