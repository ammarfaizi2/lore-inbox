Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUDNNtO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUDNNtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:49:14 -0400
Received: from mailrelay3.alcatel.de ([194.113.59.71]:19921 "EHLO
	mailrelay1.alcatel.de") by vger.kernel.org with ESMTP
	id S261263AbUDNNtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:49:12 -0400
From: Daniel Ritz <daniel.ritz@alcatel.ch>
Reply-To: daniel.ritz@gmx.ch
To: Len Brown <len.brown@intel.com>, Kitt Tientanopajai <kitt@gear.kku.ac.th>
Subject: Re: [PATCH] fix Acer TravelMate 360 interrupt routing
Date: Wed, 14 Apr 2004 15:47:35 +0200
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <A6974D8E5F98D511BB910002A50A6647615F8369@hdsmsx403.hd.intel.com> <1081906004.2258.673.camel@dhcppc4>
In-Reply-To: <1081906004.2258.673.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141547.36010.daniel.ritz@alcatel.ch>
X-Alcanet-virus-scanned: i3EDmLi8009547 at mailrelay1.alcatel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 03:26, Len Brown wrote:
> On Sat, 2004-04-10 at 16:24, Daniel Ritz wrote:
> >  ... routing via ACPI fails too.
>
> Does everything work when booted in ACPI mode with "pci=noacpi"?

i think yes.

but let's ask the originator of the bug report. kitt you there?

and a pointer to the original discussion.
	http://marc.theaimsgroup.com/?t=108113124000003&r=1&w=2
i first thougt it was the cardbus bridge sending the pci interrupt thru the
interrupt serializer, but that was not the case.

some other pointers to the problem:
	http://www.naos.co.nz/hardware/laptop/acer-361evi/x94.html#AEN138
	http://sourceforge.net/tracker/index.php?func=detail&aid=533863&group_id=2405&atid=102405


>
> If so, I wouldn't be eager to add a model-specific !ACPI mode workaround
> -- which if it goes into the kernel will be there forever.
>
> Also, I'm not enthusiastic about adding the dmi entry for "pci=noacpi"
> until we've taken a swing at finding out why Linux/ACPI doesn't work out
> of the box on this platform and given up.  For we might find a fix for
> this platform that helps other platforms.  Adding the platform-specific
> automatic workaround just masks the problem for owners of that exact
> model.
>
> So for the ACPI mode part, I encourage you to file a bug here
>
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> Component Config-Interrupts
> and assign it to me.  Or if a bug is open already,
> please direct me to it.
>
> thanks,
> -Len

