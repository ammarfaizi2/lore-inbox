Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbUJ1RuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbUJ1RuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbUJ1Rt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:49:57 -0400
Received: from alog0418.analogic.com ([208.224.222.194]:6272 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263016AbUJ1RtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:49:25 -0400
Date: Thu, 28 Oct 2004 13:46:56 -0400 (EDT)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Phy Prabab <phyprabab@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Help understanding memory layout
In-Reply-To: <20041028172125.67969.qmail@web51808.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0410281332160.14514@chaos.analogic.com>
References: <20041028172125.67969.qmail@web51808.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Phy Prabab wrote:

> Hello,
>
> I need some help understanding memory layout of
> applications within memory under linux.  I am using
> the command "pmap" to understand where all the
> elements of my application are laying and found that I
> just do not understand how and why it is layed out in
> a particular fashion.  Is there documentation that
> could help me understand memory management under
> Linux?
>
> Thank you for your time.
> Phy


You can look in /proc/PID/maps to see where memory-mapped
stuff exists. PID is the process-ID number.

You can also use printf("%p\n", function); to get the
offset of any function in your code. Using this same
method, you can also print the offset of anything that
can be labeled in your code.

These offsets are only useful for mental
masturbation. If your application needs to know
the layout of its code and data it is severely
broken and needs to be fixed. All data elements
are accessible using conventional language methods
such as pointers, array elements, and structure
members.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
