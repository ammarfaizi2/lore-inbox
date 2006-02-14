Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbWBNJcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbWBNJcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWBNJcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:32:55 -0500
Received: from cantor2.suse.de ([195.135.220.15]:51135 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030528AbWBNJcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:32:55 -0500
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH 0/4] PCI legacy I/O port free driver
References: <43F172BA.1020405@jp.fujitsu.com>
From: Andi Kleen <ak@suse.de>
Date: 14 Feb 2006 10:32:46 +0100
In-Reply-To: <43F172BA.1020405@jp.fujitsu.com>
Message-ID: <p7364ni475t.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> writes:

> I encountered a problem that some PCI devices don't work on my system
> which have huge number of PCI devices.

Is that a large IA64 system?

[...]

The basic concept looks good to me, but I would suggest you use
the Linux bitmap functions (DECLARE_BITMAP(), set_bit, test_bit etc.)
instead of open coding all that.

And for the e1000 change - instead of adding a big switch with
magic numbers that will likely bitrot it's better to use 
the driver_data field in pci_device_id for such device specific flags.

-Andi
