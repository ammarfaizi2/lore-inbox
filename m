Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbUKCTOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbUKCTOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbUKCTOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:14:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32666 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261821AbUKCTN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:13:59 -0500
Message-ID: <41892DE3.5040402@pobox.com>
Date: Wed, 03 Nov 2004 14:13:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
References: <20041103091039.GA22469@taniwha.stupidest.org> <41891980.6040009@pobox.com> <20041103190757.GA25451@taniwha.stupidest.org>
In-Reply-To: <20041103190757.GA25451@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Wed, Nov 03, 2004 at 12:46:40PM -0500, Jeff Garzik wrote:
> 
> 
>>Wrong.  There are way too many __correct__ drivers to do this at
>>present.
> 
> 
> i could claim the same is true of MODULE_PARM yet we spew
> warning-galore there...

There is a 2.4 version of module_param().

The semantics of pci_module_init() versus pci_register_driver() are 
different across 2.4/2.6.  If you deprecate pci_module_init(), you are 
breaking drivers which right now can be ported to 2.4 with a simple cp(1).

It's just downright silly to deprecate the API that is used most heavily 
in drivers.

	Jeff



