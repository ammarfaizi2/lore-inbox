Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbULVPVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbULVPVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 10:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbULVPVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 10:21:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:7059 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261858AbULVPVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 10:21:20 -0500
Message-ID: <41C990CA.20208@sgi.com>
Date: Wed, 22 Dec 2004 09:20:42 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       matthew@wil.cx
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
References: <200412220028.iBM0SB3d299993@fsgi900.americas.sgi.com> <20041222134423.GA11750@infradead.org> <20041222140348.A1130@flint.arm.linux.org.uk>
In-Reply-To: <20041222140348.A1130@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Dec 22, 2004 at 01:44:23PM +0000, Christoph Hellwig wrote:
> 
>>>I still save off the pci_dev ptrs for all cards found, so I can
>>>register with the serial core after probe (is there a better way?).
>>>Should I register the driver separately for each card ? That seems a
>>>bit overkill.
>>
>>You should register them with the serial core in ->probe.
> 
> 
> You want to register with the serial core before you register with PCI.
> Then add each port when you find it via the PCI driver ->probe method.
> 
> Removal is precisely the reverse order - remove each port in ->remove
> method first, then unregister from serial core.
> 

How do I know how many ports I have when I register with serial core ? I use the info I got when i 
probed to fill in .nr

-- Pat
