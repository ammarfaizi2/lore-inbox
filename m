Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSKVN3v>; Fri, 22 Nov 2002 08:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSKVN3v>; Fri, 22 Nov 2002 08:29:51 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:49291 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S264771AbSKVN3r>; Fri, 22 Nov 2002 08:29:47 -0500
Date: Fri, 22 Nov 2002 14:36:43 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [ACPI] RE: [PATCH] Allow others to use ACPI EC interface
Message-ID: <20021122133643.GA2224@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org, acpi-devel@sourceforge.net,
	Patrick Mochel <mochel@osdl.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A536@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A536@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 06:03:27PM -0800, Grover, Andrew wrote:

> > Well, not directly related to the EC thing but rather to the 
> > ACPI/sonypi
> > integration, but maybe you noticed that the sonypi driver also
> > re-implements some code which is originally defined in the ACPI bios
> > (SRS, DIS methods on "SPIC" ACPI object). 
> > 
> > One day I should really call some ACPI exported function to do this,
> > but last time I looked at this (3 months ago ?), the ACPI API (the one
> > exported to external users) was still changing each day. 
> 
> Yeah I think the interface is settling down. You should be able to look at
> the code in drivers/acpi or drivers/hotplug/acpiphp* for examples.

Ok, thanks.

> >From looking at other Sony ACPI BIOSes I've collected, it appears that SPIC
> has a hardware ID (HID) in the ACPI namespace. It seems analogous to the
> Toshiba Laptop Extras device in drivers/acpi.

Indeed.

> 
> Indeed, I think a sonypi driver that assumes ACPI will be much shorter and
> look quite different from the current one. 

Not so sure about that, because only the sonypi device init/free
make use of ACPI. After that, I still have to use the 'proprietary'
protocol over the sonypi iports.

It will simplify the code a little, especially when dealing with new
models which could have a third initialisation way (we already handle
2 differents Vaio types). 

But once again, the old code is here to stay, until/if ACPI becomes
mandatory.

> But since we have resolved the EC
> contention issues, this need not be addressed immediately.

Agreed, this is a low priority item, I'll take a look at the
existent ACPI drivers when I'll have a slow weekend...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
