Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbTI0P1C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 11:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTI0P1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 11:27:02 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:50616 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262467AbTI0P07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 11:26:59 -0400
Date: Sat, 27 Sep 2003 17:26:57 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Len Brown <len.brown@intel.com>, marcelo@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: HT not working by default since 2.4.22
Message-ID: <20030927152657.GA31944@DUK2.13thfloor.at>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Len Brown <len.brown@intel.com>,
	marcelo@parcelfarce.linux.theplanet.co.uk,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <Pine.LNX.4.44.0309251426570.30864-100000@parcelfarce.linux.theplanet.co.uk> <3F738288.5060304@pobox.com> <1064547463.2981.833.camel@dhcppc4> <20030926034951.GA12338@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030926034951.GA12338@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 11:49:51PM -0400, Jeff Garzik wrote:
> On Thu, Sep 25, 2003 at 11:37:43PM -0400, Len Brown wrote:
> > > How about the more simple CONFIG_HYPERTHREAD or CONFIG_HT?
> > > 
> > > If enabled and CONFIG_SMP is set, then we will attempt to discover HT 
> > > via ACPI tables, regardless of CONFIG_ACPI value.
> > 
> > Yes, except I think we should keep the name CONFIG_ACPI_HT_ONLY since it
> > says exactly what it does.
> > 
> > Hopefully I can make it looke clear in the menus --
> > I think on the config menus for CONFIG_ACPI_HT_ONLY and CONFIG_ACPI
> > should be mutually exclusive.
> 
> Now that I've thought of it (aren't I humble), I rather like CONFIG_HT.
> It's simple and it's effects should be obvious to both developer and
> user:
> 
> 	CONFIG_HT, CONFIG_ACPI == ACPI
> 	!CONFIG_HT, CONFIG_ACPI == ACPI
> 	CONFIG_HT, !CONFIG_ACPI == HT-only ACPI
> 	!CONFIG_HT, !CONFIG_ACPI == no ACPI

what about making the CONFIG_HT disappear when 
CONFIG_ACPI is selected?

by the way I would name it CONFIG_HT_ACPI ..

on the other hand, what do I know about that?  ;)
so just take it as another opinion ...

best,
Herbert

> Following the "autoconf model", what we really want to be testing with
> CONFIG_xxx is _features_, where possible. "hyperthreading: yes/no" is
> IMO more clear than "do I want ht-only ACPI or full ACPI", while at the
> same time being more fine-grained and future-proof.
> 
> 
> > > Or... (I know multiple people will shoot me for saying this) we could 
> > > resurrect acpitable.[ch], and build that when CONFIG_ACPI is disabled.
> > 
> > The question about configs is independent of the acpitable.[ch] vs
> > table.c implementation.  No, we should not return to maintaining two
> > copies of the acpi table code.
> 
> Point; agreed.
> 
> 	Jeff
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
