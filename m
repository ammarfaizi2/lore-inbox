Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVBBUt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVBBUt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVBBUpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:45:11 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46816 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262805AbVBBUif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 15:38:35 -0500
Message-ID: <420139BF.4000100@sgi.com>
Date: Wed, 02 Feb 2005 14:36:15 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, matthew@wil.cx,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] Altix : ioc4 serial driver support
References: <20050103140938.GA20070@infradead.org> <Pine.SGI.3.96.1050131164059.62785B-100000@fsgi900.americas.sgi.com> <20050201092335.GB28575@infradead.org>
In-Reply-To: <20050201092335.GB28575@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Jan 31, 2005 at 04:45:05PM -0600, Pat Gefre wrote:
> 
> Please kill ioc4_ide_init as it's completely unused and make ioc4_serial_init
> a normal module_init() handler in ioc4_serial, there's no need to call
> them from the generic driver.
> 

I want ioc4_serial_init called before pci_register_driver() if I make it a
module_init() call I have no control over order ??

> Do you need to use ide_pci_register_driver?  IOC4 doesn't have the legacy
> IDE problems, and it's never used together with such devices in a system,
> so a plain pci_register_driver should do it.
> 

So ide_pci_register_driver is only for legacy devices with certain IDE
problems - I think that is what you are saying (just trying to make sure
I have it right) ??


Thanks for the review,
-- Pat
