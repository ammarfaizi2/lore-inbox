Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWE2V7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWE2V7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWE2V7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:59:45 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3035 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751407AbWE2V7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:59:44 -0400
Message-ID: <447B6ECB.9080207@pobox.com>
Date: Mon, 29 May 2006 17:59:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <gregkh@suse.de>
Subject: Re: searching for pci busses
References: <4478DCF1.8080608@gmail.com> <20060529214753.GD10875@kroah.com>
In-Reply-To: <20060529214753.GD10875@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, May 28, 2006 at 01:12:26AM +0159, Jiri Slaby wrote:
>> Hello,
>>
>> I want to ask, if there is any function to call (as we debated with Jeff), which
>> does something like this:
>> 1) I have some vendor/device ids in table
>> 2) I want to traverse raws of the table and compare to system devices, and if
>> found, stop and return pci_dev struct (or raw in the table).
> 
> What's wrong with pci_match_id()?
> 
> Or just using the pci_register_driver() function properly, which handles
> all of this logic for you?

These aren't PCI devices proper.  These are embedded non-PCI devices, 
which must search for an unrelated PCI device to figure out what type of 
platform they are on.

	Jeff



