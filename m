Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbVKCTQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbVKCTQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 14:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbVKCTQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 14:16:34 -0500
Received: from amdext3.amd.com ([139.95.251.6]:44780 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1030410AbVKCTQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 14:16:34 -0500
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Subject: Re: AMD Geode GX/LX Support (Refreshed)
From: "John Zulauf" <john.zulauf@amd.com>
Reply-to: john.zulauf@amd.com
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
cc: "Jordan Crouse" <jordan.crouse@amd.com>, linux-kernel@vger.kernel.org,
       info-linux@ldcmail.amd.com
In-Reply-To: <LYRIS-4271-75416-2005.11.01-16.24.38--john.zulauf#amd.com@whitestar.amd.com>
References: <LYRIS-4271-75416-2005.11.01-16.24.38--john.zulauf#amd.com@whitestar.amd.com>
Organization: AMD Longmont Design Center
Date: Thu, 03 Nov 2005 12:16:48 -0700
Message-ID: <1131045408.5959.27.camel@zoom.amd.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4)
X-WSS-ID: 6F74BD8C2VS1926695-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I've done the benchmarking of the 3DNOW and non-3DNOW configured Geode
GX/LX.  This was done by extracting the kernel memcpy code into a
userland test application.  Time measurement were made using rdtsc.

The results are averaged over 4 test runs on a Geode LX. The tot_memcpy
is the total CPU clocks to run every memcpy from len = 2
through 4095 four times.  For the 3DNOW version this even includes the 

if (len <512){  __memcpy ... } 

escape found in the kernel __memcpy3d mmx_memcpy wrapper function. 

               No 3DNOW w/ 3DNOW  improvement
tot_memcpy      4635754 4360040  5.9%
tot_copy_page      2324    1853 20.3%
tot_clear_page     4398    1427 67.5%

These are meaningful improvement and the 3DNOW config should be enabled
for Geode GX and LX.

Best Regards,

John Zulauf

On Tue, 2005-11-01 at 23:53 +0000, Alan Cox wrote:
> On Maw, 2005-11-01 at 16:10 -0700, Jordan Crouse wrote:
> > in my app, I think we should leave X86_USE_PPRO_CHECKSUM enabled for Geode
> > GX/LX.
> 
> Definitely.
> 
> 
> 
> 
> ---
> You are currently subscribed to info-linux@geode.amd.com
> as: john.zulauf@amd.com
> To unsubscribe send a blank email to:
> leave-info-linux-4271N@whitestar.amd.com
-- 
John Zulauf
Senior MTS, Embedded Core Software
Advanced Micro Devices, Inc.
1351 So Sunset St
Longmont, CO 80501

303 774 5166 office
303 774 5801 fax


