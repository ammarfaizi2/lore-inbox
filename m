Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbTEOTsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTEOTsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:48:38 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:24906 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264193AbTEOTsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:48:36 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <1053027740.2095.44.camel@diemos>
References: <Pine.LNX.4.44L0.0305151355290.1139-100000@ida.rowland.org>
	 <1053027740.2095.44.camel@diemos>
Content-Type: text/plain
Organization: 
Message-Id: <1053028778.2660.7.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 May 2003 14:59:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 14:42, Paul Fulghum wrote:
> On Thu, 2003-05-15 at 13:11, Alan Stern wrote:
> > Maybe they are an Intel-specific addition?  Or perhaps a more 
> > recent version of the spec has more information -- the one I've got is 1.1 
> > (March 1996).
> 
> I can't find any later documents.
> 
> > Can you suggest a good way of detecting whether or not a controller is
> > part of a PIIX4 chipset, to indicate whether or not the OC bits are valid?
> 
> I don't see a generic way to determine the validity of these bits.
> 
> I think the PCI ID is the only way:
> Vendor ID 8086
> Device ID 7112
> 
> The erratum is only for the PIIX4, and it is
> triggered only when the OC inputs are active,
> so limiting the check to that device should
> be OK.

More clarification (at a suggestion from Charles Lepple):
The errata covers all steppings of the 82371AB/EB/MB
with a note that this bug will never be fixed
in these devices.

So checking for 8086:7112 should be sufficient without
a need to check the version number.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


