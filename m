Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWAQVk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWAQVk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWAQVk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:40:28 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42132 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751271AbWAQVk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:40:27 -0500
From: Junio C Hamano <junkio@cox.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: pata_oldpiix rev 0.2
References: <1136387989.4121.4.camel@localhost.localdomain>
	<43CCEF25.2090902@pobox.com>
Date: Tue, 17 Jan 2006 13:40:24 -0800
In-Reply-To: <43CCEF25.2090902@pobox.com> (Jeff Garzik's message of "Tue, 17
	Jan 2006 08:20:37 -0500")
Message-ID: <7vpsmq7ctz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Alan Cox wrote:
>> static void oldpiix_pata_phy_reset(struct ata_port *ap)
>...
>> static void oldpiix_set_piomode (struct ata_port *ap, struct
>>...
>> 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
>> 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
>> 	unsigned int idetm_port= ap->hard_port_no ? 0x42 : 0x40;
>
> space after '='?

I think you meant space before '='.

Did you have to quote the entire patch?  It was quite annoying
to read.

Ideally, "this applies on top of your patch, to address these
issues", would be the easiest to read, but that would require
you to actually apply Alan's patch on your tree, do your
modifications and produce another patch (IOW, it would be more
work on your part).  Just to provide quick comments, if you
trimmed the patch you quoted from Alan's when commenting,
leaving enough material for Alan and others to identify the
pieces you are commenting on, it would have been a lot easier to
read (it would be more work for the contributor, but it is his
patch after all).

