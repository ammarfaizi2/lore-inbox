Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbUL2FjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbUL2FjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 00:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbUL2FjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 00:39:25 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:779 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261323AbUL2FjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 00:39:21 -0500
Date: Wed, 29 Dec 2004 06:34:28 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need hardware (chip) guru
Message-ID: <20041229053428.GO17946@alpha.home.local>
References: <200412282110.59601.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412282110.59601.gene.heskett@verizon.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene,

On Tue, Dec 28, 2004 at 09:10:59PM -0500, Gene Heskett wrote:
> I've read through the Intel pdf doc sheets on the Intel 82c55 about 4 
> times now, looking for clues, but everything about the control 
> register seems to be write only.  Their logic diagrams don't even 
> acknowledge the existance of the control register.

Look at Table 1 page 2 (pin description). There is a table which details
which data goes on the bus for each address in read and in write mode.
If you read address 3, it should return the control reg (according to
the table).

> Is there anyone here who can tell me how to read the current status of 
> the ctl register in an 82C55?
> 
> The std inb(ctl_address, byte); is returning 0xff regardless of what I 
> write with the corresponding outb statement <10 microseconds in front 
> of the read.

Have you tried delaying more ?

Honnestly, I don't remember if I have ever read the control reg. Since it's
more of a command than a register, it does not make much sense (depending
on bit 7, it does different things). So at most, you would read the last
command sent to the chip. I don't know if this can be very useful.

Regards,
Willy

PS: for any replies, please post off-list, it seems a little off-topic

