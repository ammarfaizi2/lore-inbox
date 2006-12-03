Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936642AbWLCDfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936642AbWLCDfJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 22:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936643AbWLCDfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 22:35:09 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:42187 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S936642AbWLCDfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 22:35:06 -0500
Date: Sat, 2 Dec 2006 19:35:03 -0800
From: "Kurtis D. Rader" <krader@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives
Message-ID: <20061203033503.GB2729@us.ibm.com>
References: <4570CF26.8070800@scientia.net> <20061203011737.GA2729@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061203011737.GA2729@us.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-02 17:17:37, Kurtis D. Rader wrote:
> The same disks attached to a Promise TX2 SATA controller (in the same
> system) experience no corruption.

I spoke too soon. Corruption is occurring with the disks attached to the
Promise TX2 SATA controller but much less frequently. With the drives
attached to the nVidia controller copying certain 2 GiB files would
result in at least five bytes, and as many as thirty, being corrupted
every single time. On the Promise controller a given copy is likely to be
good. And when corruption does occur fewer bytes are being affected ---
as little as a single byte in a 2 GiB file. But still, some files never
show corruption while others do.

The Promise controller in a PCI slot is measurably slower than the nVidia
on the baseboard so the speed of the transfers appears to be a factor. In
addition to the pattern of data. My hunch is this is a nVidia nForce 4
chipset design defect involving buss crosstalk or something similar. Which
may be why I'm not seeing it when writing to my relatively slow PATA disks.

-- 
Kurtis D. Rader, Linux level 3 support  email: krader@us.ibm.com
IBM Integrated Technology Services      DID: +1 503-578-3714
15300 SW Koll Pkwy, MS RHE2-O2          service: 800-IBM-SERV
Beaverton, OR 97006-6063                http://www.ibm.com
