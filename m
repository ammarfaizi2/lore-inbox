Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTIZDig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 23:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTIZDig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 23:38:36 -0400
Received: from fmr04.intel.com ([143.183.121.6]:32387 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261873AbTIZDie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 23:38:34 -0400
Subject: Re: HT not working by default since 2.4.22
From: Len Brown <len.brown@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: marcelo@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
In-Reply-To: <3F738288.5060304@pobox.com>
References: <Pine.LNX.4.44.0309251426570.30864-100000@parcelfarce.linux.theplanet.co.uk>
	 <3F738288.5060304@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1064547463.2981.833.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Sep 2003 23:37:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately CONFIG_ACPI_HT_ONLY outside and independent of CONFIG_ACPI 
> proved a bit confusing.

It was outside, but it wasn't independent -- and _that_ I think was the
source of confusion.

CONFIG_ACPI depended on CONFIG_ACPI_HT.  This looked good on paper
because CONFIG_ACPI_HT is a sub-set of CONFIG_ACPI...

But people who wanted ACPI but didn't want HT (eg. everybody with a PIII
laptop...) were perplexed that they had to "enable HT" in order to get
ACPI.

> How about the more simple CONFIG_HYPERTHREAD or CONFIG_HT?
> 
> If enabled and CONFIG_SMP is set, then we will attempt to discover HT 
> via ACPI tables, regardless of CONFIG_ACPI value.

Yes, except I think we should keep the name CONFIG_ACPI_HT_ONLY since it
says exactly what it does.

Hopefully I can make it looke clear in the menus --
I think on the config menus for CONFIG_ACPI_HT_ONLY and CONFIG_ACPI
should be mutually exclusive.

> Or... (I know multiple people will shoot me for saying this) we could 
> resurrect acpitable.[ch], and build that when CONFIG_ACPI is disabled.

The question about configs is independent of the acpitable.[ch] vs
table.c implementation.  No, we should not return to maintaining two
copies of the acpi table code.

thanks,
-Len




