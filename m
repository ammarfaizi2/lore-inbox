Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbULXUpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbULXUpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 15:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbULXUpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 15:45:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:8854 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261446AbULXUpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 15:45:01 -0500
Subject: Re: apic and 8254 wraparound ...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041224200022.GA14956@mail.13thfloor.at>
References: <20041224001144.GA5192@mail.13thfloor.at>
	 <1103845033.15193.6.camel@localhost.localdomain>
	 <20041224200022.GA14956@mail.13thfloor.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103917238.18115.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Dec 2004 19:40:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-24 at 20:00, Herbert Poetzl wrote:
> somehow I'm unable to locate it, I can see the 
> 430TX and 430HX but not the 430NX and 430LX ...
> 
> do you have an url for me?

Not to hand, its under the retired chipset stuff. The details are as
follows from memory

When you read one 8bit value from an 8254 timer the values latch for
read so that when you read the other half of the 16bit value you get the
value from the moment of the first read. On 
neptune that didn't work right so you got halves of two differing
samples. That means the error would be worst case a bit under 300 (257
for the wrap + a few for timing)

