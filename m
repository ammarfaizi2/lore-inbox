Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWIAPvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWIAPvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWIAPvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:51:17 -0400
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:49887 "EHLO
	outbound1-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932097AbWIAPvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:51:14 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Fri, 1 Sep 2006 09:51:17 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
cc: "Len Brown" <lenb@kernel.org>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "ACPI ML" <linux-acpi@vger.kernel.org>,
       "Adam Belay" <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Arjan van de Ven" <arjan@linux.intel.com>, devel@laptop.org,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: ACPI: Idle Processor PM Improvements
Message-ID: <20060901155117.GD18448@cosmic.amd.com>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
 <200608311713.21618.bjorn.helgaas@hp.com>
 <1157070616.7974.232.camel@localhost.localdomain>
 <200608312353.05337.len.brown@intel.com>
 <20060901041221.GA15330@srcf.ucam.org>
MIME-Version: 1.0
In-Reply-To: <20060901041221.GA15330@srcf.ucam.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Sep 2006 15:51:10.0048 (UTC)
 FILETIME=[71B0BE00:01C6CDDE]
X-WSS-ID: 68E689670C41477645-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/06 05:12 +0100, Matthew Garrett wrote:
> On Thu, Aug 31, 2006 at 11:53:04PM -0400, Len Brown wrote:
> 
> > The Geode doesn't suport any C-states -- so ACPI wouldn't help them there anyway.
> 
> Are you sure of that? The docs I have here suggest C1 and C2, but it's 
> possible that that's just the companion chip and they aren't implemented 
> in the CPU.

C1 is essentially suspend on hlt.  We have something called Automatic Hardware
Clock Gating that kicks in when the blocks go unused, so that saves a bit
more power (especially in the south bridge) then we would with just a simple
hlt.  In any event, this already happens without the assistance of ACPI.

The 5536 has support for a C2 state as well, but I don't know if that
has any effect on the GX or not.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


