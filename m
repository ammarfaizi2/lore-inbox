Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVBGQBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVBGQBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVBGQBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:01:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:27327 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261167AbVBGQBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:01:32 -0500
Message-ID: <42079029.5040401@sgi.com>
Date: Mon, 07 Feb 2005 09:58:33 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, matthew@wil.cx,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] Altix : ioc4 serial driver support
References: <20050103140938.GA20070@infradead.org> <Pine.SGI.3.96.1050131164059.62785B-100000@fsgi900.americas.sgi.com> <20050201092335.GB28575@infradead.org> <420139BF.4000100@sgi.com> <20050202215716.GA23253@infradead.org>
In-Reply-To: <20050202215716.GA23253@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Feb 02, 2005 at 02:36:15PM -0600, Patrick Gefre wrote:
> 
>>>Please kill ioc4_ide_init as it's completely unused and make 
>>>ioc4_serial_init
>>>a normal module_init() handler in ioc4_serial, there's no need to call
>>>them from the generic driver.
>>>
>>
>>I want ioc4_serial_init called before pci_register_driver() if I make it a
>>module_init() call I have no control over order ??
> 
> 
> For the modular case it'd always be executed before because the module
> must be loaded first, for the builtin case it'd depend on the link order.
> 
> Let's leave it as-is, it's probably safer.
> 
> 


Latest version with review mods:
ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support

Signed-off-by: Patrick Gefre <pfg@sgi.com>
