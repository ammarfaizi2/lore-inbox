Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423050AbWBBBqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423050AbWBBBqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423052AbWBBBqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:46:05 -0500
Received: from [81.2.110.250] ([81.2.110.250]:10150 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1423050AbWBBBqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:46:04 -0500
Subject: Re: 8250 serial console fixes -- issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: rmk+kernel@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Feb 2006 01:47:18 +0000
Message-Id: <1138844838.5557.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-01 at 19:21 -0600, Kumar Gala wrote:
> This patch introduces an issue for me an embedded PowerPC SoC using the 
> 8250 driver.
> 
> The simple description of my issue is this:  I'm using the serial port for
> both a terminal and console.  I run fdisk on a /dev/hda.  Before this
> patch I would get the prompt for fdisk immediately.  After this patch I
> have to hit return before the prompt is displayed.
> 
> I know that's not a lot of info, but just let me know what else you need 
> to help debug this.
> 
> I'm guessing something about the UARTs on the PowerPC maybe bit a little 
> non-standard.

I wonder if I've swapped one race for another. Can you revert just the
line which forces THRI on and test with the rest of the change please.

