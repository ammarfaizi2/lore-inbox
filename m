Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTIZAEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 20:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTIZAEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 20:04:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59807 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261168AbTIZAEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 20:04:36 -0400
Message-ID: <3F738288.5060304@pobox.com>
Date: Thu, 25 Sep 2003 20:04:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo@parcelfarce.linux.theplanet.co.uk
CC: "Brown, Len" <len.brown@intel.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: HT not working by default since 2.4.22
References: <Pine.LNX.4.44.0309251426570.30864-100000@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.44.0309251426570.30864-100000@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

marcelo@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, 24 Sep 2003, Brown, Len wrote:
> 
> 
>>Okay, so what to do?
>>
>>We could make 2.4.23 like 2.4.21 where ACPI code for HT is included in
>>the kernel even when CONFIG_ACPI is not set.
>>
>>Or we could leave 2.4.23 like 2.4.22 where disabling CONFIG_ACPI really
>>does remove all ACPI code in the kernel; and when CONFIG_ACPI is set,
>>CONFIG_ACPI_HT_ONLY is available to limit ACPI to just the tables part
>>needed for HT.
> 
> 
> CONFIG_ACPI_HT should be not dependant on CONFIG_ACPI. So
> 
> 1) Please make it very clear on the configuration that for HT 
> CONFIG_ACPI_HT_ONLY is needed
> 2) Move it outside CONFIG_ACPI. 
> 
> OK? 


Unfortunately CONFIG_ACPI_HT_ONLY outside and independent of CONFIG_ACPI 
proved a bit confusing.

How about the more simple CONFIG_HYPERTHREAD or CONFIG_HT?

If enabled and CONFIG_SMP is set, then we will attempt to discover HT 
via ACPI tables, regardless of CONFIG_ACPI value.

Or... (I know multiple people will shoot me for saying this) we could 
resurrect acpitable.[ch], and build that when CONFIG_ACPI is disabled.

	Jeff



