Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757069AbWKVWLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069AbWKVWLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 17:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757070AbWKVWLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 17:11:22 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63405 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757068AbWKVWLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 17:11:22 -0500
Date: Wed, 22 Nov 2006 22:17:31 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: [RFC] char: Add MFGPT driver for the CS5535/CS5536
Message-ID: <20061122221731.356939cb@localhost.localdomain>
In-Reply-To: <20061122205736.GA588@cosmic.amd.com>
References: <20061122205736.GA588@cosmic.amd.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 13:57:36 -0700
"Jordan Crouse" <jordan.crouse@amd.com> wrote:

> The Geode CS5535 and CS5536 companion chips contain a block of timers
> known as the Multi Function General Purpose Timers.  The primary use
> for these timers is to control an output pin nominally connected to a
> LED or other visual indicator.  They also can be configured to reset the
> system, which is handy as a watchdog timer.  they _can_ be used to
> fire software interrupts on timeout too, but this is less useful since the
> timers are fairly low resolution and there are much better options available.
> 
> The attached driver provides a low-level interface to the block, and 
> allows for other kernel drivers to use the timers. 

Three comments

1.	Use inlines not defines when you can - it means we get type
checking
2.	There is an RTC timer interface - could you use that interface
for some of this so its compatible and consistent ?
3.	Ditto for a watchdog use - although that would be a separate
driver using the kernel hooks anyway.

Kernel side looks fairly sane
