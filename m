Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWADPGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWADPGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 10:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWADPGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 10:06:03 -0500
Received: from usea-naimss1.unisys.com ([192.61.61.103]:4617 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1750817AbWADPGC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 10:06:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Patch] es7000 broken without acpi
Date: Wed, 4 Jan 2006 09:05:42 -0600
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B09B4@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] es7000 broken without acpi
Thread-Index: AcYRFmk7dRGyIg4KRxOkmHDGUBocsgAH9UEg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Peter Hagervall" <hager@cs.umu.se>, "Andrew Morton" <akpm@osdl.org>,
       <ak@suse.de>
Cc: "Eric Sesterhenn / snakebyte" <snakebyte@gmx.de>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Jan 2006 15:05:43.0231 (UTC) FILETIME=[553D7CF0:01C61140]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 03, 2006 at 03:48:08PM -0800, Andrew Morton wrote:
> > 
> > I believe that es7000 requires ACPI, so a better fix would be to 
> > enforce that within Kconfig.
> > 
> > Natalie, can you please comment?
> > 
> 
> This was discussed back in October [1], but nothing became of 
> it. Should I resend the patch perhaps?
> 
> 	Peter
> 
> [1] http://marc.theaimsgroup.com/?t=112928755800002&r=1&w=2
> 

The only possible problem I see with that patch is making genapic
dependant on ACPI, which I'm not sure about (for example, if Summit
would want that, but nobody commented back then...Andi, what do you
think?) As for ES7000, it fixes build problem overall, however, maybe it
would be prudent to make it builldable even without its dependency on
ACPI, just for correctness sake, meaning properly #ifdef-ing ACPI parts,
this will make it more versatile (even though I cannot think of
situation it might be used...Andi, what do you think? :) 
--Natalie
