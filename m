Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbTHYWmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbTHYWl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:41:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14039 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262408AbTHYWlt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:41:49 -0400
Message-ID: <3F4A9096.2000700@pobox.com>
Date: Mon, 25 Aug 2003 18:41:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [CFT] Clean up yenta_socket
References: <20030825003529.K16635@flint.arm.linux.org.uk>
In-Reply-To: <20030825003529.K16635@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WIBNI?

Anyway, MSI needs more than the standard size as well.

But I would actually prefer the interface to go the other way:

	pci_save_state(pdev);
		and
	pci_restore_state(pdev);

Allocate and store the state in a pointer in struct pci_dev, or 
somesuch.  And somebody other than the low-level driver figures out the 
amount to save and restore.

	Jeff



