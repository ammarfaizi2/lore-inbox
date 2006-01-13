Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWAMPVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWAMPVO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWAMPVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:21:14 -0500
Received: from host27-37.discord.birch.net ([65.16.27.37]:51043 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S964968AbWAMPVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:21:13 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'don fisher'" <dfisher@as.arizona.edu>, <linux-kernel@vger.kernel.org>
Subject: RE: machine check errors
Date: Fri, 13 Jan 2006 09:31:18 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYX0HnBtpjb5n5vTe6edg+IiojdiAAg+MJg
In-Reply-To: <43C6E834.7040402@as.arizona.edu>
Message-ID: <EXCHG2003THfyQgeDKv00000c7e@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 13 Jan 2006 15:14:49.0201 (UTC) FILETIME=[1861A610:01C61854]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of don fisher
> Sent: Thursday, January 12, 2006 5:37 PM
> To: linux-kernel@vger.kernel.org
> Subject: machine check errors
> 
> I have a Tyan S2892 board with a pair Opteron 288 dual core 
> cpus and 16GB dram. I receive the errors shown in the 
> attached file, mcelog. It appears that these occur when the 
> free memory becomes small, there is a lot in the cache, and a 
> lot of IO.

You probably mean Opteron 285's. or Opteron 280's.

> 
> The Tyan S2892 has an Nvidia Crush K8-04, which I think they 
> call the southbridge. My errors appear to be related to the 
> north bridge. There is an AMD 8131 PCI-X controller that runs 
> the PCI slots. There is a 3WARE 9500-12 located in one of the 
> PCI-X slots.
> 
> I have run Memtest86+-1.65 for 24 hours without errors. I 
> recently upgraded the BIOS to V2.00 without any remarkable changes.

Does memtest86+ support reading of ecc errors on that motherboard,
if it does not, memtest won't tell you anything as the hardware
ecc will correct the errors and memtest will not find anything, if
that version of memtest is ecc aware it will register an ecc error.

> 
> I am running 2.6.15 within a current Fedora Core4 configuration.
> 
> I would appreciate any advice as to how to proceed. I have 
> not noticed any adverse behavior from the mce's. But that 
> could be masked is data transfered or ???.

Download edac/bluesmoke from sourceforge and compile and install
it, this will monitor ecc errors from linux, and should tell you
if you are getting ecc errors.

If you were running certain other Linux distributions they won't
report mces as they are missing the mcelog program, but the errors
would have been there.

> 
> Could there be any connection with the memory cache? Thanks 
> in advance for your assistance.
> 
> don

Non-fatal mce's are usually ecc faults, and *USUALLY* track back
to bad memory, though it can also be overheating cpu, or a problematic cpu, 
or rarely the MB could be the fault.

ECC/MCE counts will get worse under load, unless the problem is
really severe you won't see them at idle.

                     Roger
			   Atipa Technologies

