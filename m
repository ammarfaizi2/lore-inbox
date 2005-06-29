Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVF2RcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVF2RcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVF2RVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:21:04 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:17709 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S262653AbVF2RRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:17:10 -0400
Message-ID: <42C2D791.9020204@pantasys.com>
Date: Wed, 29 Jun 2005 10:17:05 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean Bruno <sean.bruno@dsl-only.net>
CC: linux-kernel@vger.kernel.org, kevin.mullins@asusts.com,
       JASON_RILEY@asusts.com, karim@opersys.com,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dave.jones@redhat.com
Subject: Re: ASUS K8N-DL Beta BIOS AKA PROBLEM: Devices behind	PCI	Express-to-PCI
 bridge not mapped
References: <1119996349.3484.40.camel@oscar.metro1.com>	 <42C1FD7F.2060003@opersys.com> <1120018942.6936.20.camel@home-lap>	 <42C2D3FD.2080306@pantasys.com> <1120064967.3511.4.camel@oscar.metro1.com>
In-Reply-To: <1120064967.3511.4.camel@oscar.metro1.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jun 2005 17:14:04.0875 (UTC) FILETIME=[F3B459B0:01C57CCD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Sean Bruno wrote:
>>>Aperture from northbridge cpu 0 too small (32 MB)
>>>No AGP bridge found
>>>Your BIOS doesn't leave a aperture memory hole
>>>Please enable the IOMMU option in the BIOS setup
>>>This costs you 64 MB of RAM
>>
>>this isn't a big deal, but linux expects an apperture of >= 64MB, you 
>>may want to change this setting in your bios.
>>
> 
> If the system doesn't have an AGP slot, would it even need to leave an
> aperture(this mobo has a 16x PCI-E slot for the video)?

The IOMMU is still used for some devices that are only 32bit in a 64bit 
OS. Linux actually will allocate the 64MB anyway, so it doesn't hurt to 
have the bios and linux in sync ;-)

> Would this require ASUS to modify their board/bios?

yep, good luck!

>>>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>>>    ACPI-0352: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace, AE_NOT_FOUND
>>>search_node ffff810142857180 start_node ffff810142857180 return_node 0000000000000000
>>>    ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._PRT] (Node ffff810142857140), AE_NOT_FOUND
>>
>>same as above, the acpi tables are missing information.
> 
> So, this is something that ASUS "needs" to fix or is it something that
> needs to change in the ACPI part of the kernel?

Yeah, this is again something that ASUS would need to fix in their bios. 
I'm not sure how important it is though...

peter
