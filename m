Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWICKcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWICKcq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 06:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWICKcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 06:32:46 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:36747 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751119AbWICKcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 06:32:46 -0400
Message-ID: <44FAAF4D.70404@drzeus.cx>
Date: Sun, 03 Sep 2006 12:32:45 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <44F967E8.9020503@drzeus.cx> <20060903074101.77116.qmail@web36707.mail.mud.yahoo.com> <20060903102035.GA28880@flint.arm.linux.org.uk>
In-Reply-To: <20060903102035.GA28880@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> It's really the bus we care about at this stage, since the errors we
> receive are along the lines of "the card reported that the last data
> block had a CRC error", "we encountered an underrun condition during
> the last data block", or "the card didn't request data before we
> timed out", etc.
>
> Basically, the transfer of the next block confirms that the previous
> block was successfully received by the card.
>
>   

Ehm... Now I'm a bit confused. At the point of a bus error, there
difference between the data sent to the bus and the data successfully
received by the card should amount to one block (as the last block got
NACK:ed for whatever reason). If we expect host drivers to report the
bytes sent to the bus, we need to subtract one block from the value
reported to the block layer.

Rgds
Pierre


-- 
VGER BF report: H 1.64317e-09
