Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268288AbUIPWiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268288AbUIPWiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUIPWiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:38:20 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:7071 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S268288AbUIPWh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:37:29 -0400
X-BrightmailFiltered: true
Message-Id: <5.1.0.14.2.20040917083305.04f4d008@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 17 Sep 2004 08:37:17 +1000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: The ultimate TOE design
Cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, paul@clubi.ie,
       netdev@oss.sgi.com, leonid.grossman@s2io.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095339466.22739.22.camel@localhost.localdomain>
References: <20040916133301.GA15562@wotan.suse.de>
 <20040915141346.5c5e5377.davem@davemloft.net>
 <4148991B.9050200@pobox.com>
 <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
 <1095275660.20569.0.camel@localhost.localdomain>
 <4148A90F.80003@pobox.com>
 <20040915140123.14185ede.davem@davemloft.net>
 <20040915210818.GA22649@havoc.gtf.org>
 <20040915141346.5c5e5377.davem@davemloft.net>
 <5.1.0.14.2.20040916192213.04240008@171.71.163.14>
 <1095337159.22739.7.camel@localhost.localdomain>
 <20040916133301.GA15562@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

At 10:57 PM 16/09/2004, Alan Cox wrote:
>On Iau, 2004-09-16 at 14:33, Andi Kleen wrote:
> > > At 1Ghz the Athlon Geode NX draws about 6W. Thats less than my SCSI
> >
> > Are you sure that's worst case, not average? Worst case is usually
> > much worse on a big CPU like an Athlon, but the power supply
> > has to be sized for it.
>
>You are correct - 6W average 9W TDP, still less than my scsicontroller
>8)

sure -- ok -- that gets you the main processor.
now add to that a Northbridge (perhaps AMD doesnt need that but i'm sure it 
still does), Southbridge, DDR-SDRAM, ancilliary chips for doing MAC, PHY, ...

couple that with the voltage of PCI where you're likely to need 
step-up/step-down circuits (which aren't 100% efficient themselves), you're 
still going to get very close to the limit, if not over it.

... and after all that, the Geode is really designed to be an embedded 
processor.
Jeff was implying using garden-variety processors which seem to have large 
heatsinks, not to mention cooling fans, not to mention quite significant 
heat generation.

we're not _quite_ at the stage of being able to take garden-variety 
processors and build-your-own-blade-server using PCI _just_ yet. :-)


cheers,

lincoln.

