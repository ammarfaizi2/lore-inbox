Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264076AbUFVORx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUFVORx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbUFVORw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:17:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27104 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264076AbUFVOPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:15:19 -0400
Message-ID: <40D83EE8.6090700@pobox.com>
Date: Tue, 22 Jun 2004 10:15:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gin@ginandtonic.ca
CC: linux-kernel@vger.kernel.org
Subject: Re: Don't want to share interrupts
References: <000001c4585d$98896340$0c501709@IBM3B3C778F126>
In-Reply-To: <000001c4585d$98896340$0c501709@IBM3B3C778F126>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gin@ginandtonic.ca wrote:
> I have been trying to get some platforms to work with a quad port
> Ethernet card.
> Some hardware is OK, others...well, not so OK.
> 
> An IBM x335 works OK under Linux (2.4.9) and Win2K3

methinks this is a vendor kernel, not vanilla 2.4.9.  As such, who knows 
what's in there...


> An IBM x365 Does not work under Linux.
> 
> Looks like Linux shares an IRQ between all 4 ports whereas win2k3
> doesn't .... each is assigned it's own IRQ.  Is there anyway to
> duplicate this behavior under Linux? (i.e. have an IRQ assigned to each
> port instead of sharing one for the whole card?).

IRQs are assigned by firmware.  Try turning on/off io-apic or ACPI.

But regardless, you'll need to provide a lot more information.  See 
REPORTING-BUGS in the kernel tree.

	Jeff


