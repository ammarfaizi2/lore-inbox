Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbVJEXCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbVJEXCN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbVJEXCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:02:12 -0400
Received: from amdext3.amd.com ([139.95.251.6]:42472 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1030419AbVJEXCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:02:10 -0400
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Subject: Re: AMD Geode GX/LX support V2
From: "John Zulauf" <john.zulauf@amd.com>
Reply-to: john.zulauf@amd.com
To: lsorense@csclub.uwaterloo.ca
cc: "Jordan Crouse" <jordan.crouse@amd.com>, linux-kernel@vger.kernel.org,
       info-linux@ldcmail.amd.com
In-Reply-To: <LYRIS-4271-66233-2005.10.05-13.16.03--john.zulauf#amd.com@whitestar.amd.com>
References: <20051005164626.GA25189@cosmic.amd.com>
 <20051005165405.GB25189@cosmic.amd.com>
 <20051005182947.GE8011@csclub.uwaterloo.ca>
 <20051005192711.GC1548@cosmic.amd.com>
 <LYRIS-4271-66233-2005.10.05-13.16.03--john.zulauf#amd.com@whitestar.amd.com>
Organization: AMD Longmont Design Center
Date: Wed, 05 Oct 2005 17:01:13 -0600
Message-ID: <1128553273.15143.159.camel@zoom.amd.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4)
X-WSS-ID: 6F5A84BB4NC99654-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 15:15 -0400, lsorense@csclub.uwaterloo.ca wrote:

> So the SC1200 is a GX1 and CS5530 in one chip then (given the SC1200
> doesn't need a companion chip)?  

*mostly*  The SCxx00 series does integrate the GX1 and CS5530 technology
but with some differences.  The GX1 supports a few higher graphics
resolutions, and the SCxx00 has some PCI bus speed options not supported
in the GX1/CS5530 version.  The timing values and modes are not the same
for the two IDE controllers.

Mark Lord did the initial submissions for CS5530 and SCxx00 series IDE
drivers and considered them different enough at the time to integrate
them separately (to the extant I recall).  (If you're still lurking
Mark, please feel free to correct me on any of this info.)

>From the x86 core standpoint they can be considered the same core w.r.t.
kernel configuration and capabilities -- same cacheline size, cache
size, capabilities bits (MMX, et. al.), as well as optimal scheduling
for the integer/FPU pipes.  We've found the compiling 486 is the best of
the gcc march's for the GX1/SCxx00 core.  It's unlikely that an GX1
specific scheduling will find it's way into gcc at this point.

> Currently I use the SC1200 ide driver.
> So far no DMA, but that could be because I use compact flash on the ide
> connector.  The card claims to support DMA though as far as I can tell.
> or is the SCx200 using it's own ide system?

The SC1200 should support DMA, though there may be some restrictions if
DMA and non-DMA devices are connected at the same time (i.e. it may
revert to lowest-common-mode).



-- 
John Zulauf
Senior MTS, Embedded Core Software
Advanced Micro Devices, Inc.
1351 So Sunset St
Longmont, CO 80501

303 774 5166 office
303 774 5801 fax


