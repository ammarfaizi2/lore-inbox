Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTJXKMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 06:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTJXKMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 06:12:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29919 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261780AbTJXKMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 06:12:35 -0400
Message-ID: <3F98FB06.2070805@pobox.com>
Date: Fri, 24 Oct 2003 06:12:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: r8169 bug in 2.4.22, too much work at interrupt indefinitely
References: <1066952294.616b72c0sandos@home.se> <20031023165342.79e927b5.shemminger@osdl.org>
In-Reply-To: <20031023165342.79e927b5.shemminger@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Fri, 24 Oct 2003 01:38:14 +0200
> "John Bäckstrand"  <sandos@home.se> wrote:
> 
> 
>>The r8169 driver in 2.4.22 with or without debian patches/acpi/usb devices sharing the same interrupt: the driver always ends up locking the machine by having indefinitely much to do in the interrupt handler? 
>>
>>Commented the printk out, still hangs the machine anyway. It happens even without a cable in the card. I have found no references to any bug reports at all with this card, and I cant see any bugfixes being in 2.5/2.6 but not 2.4 either. I can see the card TX/RX:ing a few hundred packets or more (3-60 secs) before hanging.
>>
>>Any way to debug this, or should I just try 2.6?
>>
>>---
>>John Bäckstrand
> 
> 
> 2.6 will have the same problem.   I have a version that uses NAPI that shouldn't hang.
> It seems to work fine, but didn't want to submit it without more testing.


Are you sure you're not thinking about 8139too, not r8169?

