Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSK0RyH>; Wed, 27 Nov 2002 12:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSK0RyG>; Wed, 27 Nov 2002 12:54:06 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:51644 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S261353AbSK0RyF>; Wed, 27 Nov 2002 12:54:05 -0500
Date: Wed, 27 Nov 2002 19:01:14 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Dennis Grant <trog@wincom.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Kernel Configuration Tale of Woe
Message-ID: <20021127180114.GB20066@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <3de507c7.1c64.0@wincom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de507c7.1c64.0@wincom.net>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 12:52:45PM -0500, Dennis Grant wrote:
> >> Agreed - so then the association between "board" 
> >> and "chipset" must be capable of being multi-valued,
> >> and when there is a mult-valued match there must be 
> >> some means of further interrogating the user (or user agent)
> >> for more information.
> > Much simpler to just include "modular everything" and let
> > user space sort it out. Guess why every vendor takes this path
> So I think there's still a need for the hardware->kernel version+config database.

The kernel source pretty close resembles what the kernel supports
(except the broken drivers). Make the source your database. Propose
source code formatting rules, and let the userspace parse it (assuming
the proposal find the way into source). Make the hardware descriptions
readable in the object code, so the userspace can pick up new modules
and activate them if a new pci-id is seen. Etc...

It's already of such use for some of us, who are about to get a new
hardware and trying to figure out if it can be useful:

egrep -rn 'vendor|cardname' .

-alex

