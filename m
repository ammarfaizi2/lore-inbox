Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135754AbRDXXRa>; Tue, 24 Apr 2001 19:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135747AbRDXXRU>; Tue, 24 Apr 2001 19:17:20 -0400
Received: from geos.coastside.net ([207.213.212.4]:25761 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S135754AbRDXXRD>; Tue, 24 Apr 2001 19:17:03 -0400
Mime-Version: 1.0
Message-Id: <p05100313b70bb73ce962@[207.213.214.37]>
In-Reply-To: <200104242159.f3OLxoB07000@vindaloo.ras.ucalgary.ca>
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E286@ausxmrr501.us.dell.com>
 <200104242159.f3OLxoB07000@vindaloo.ras.ucalgary.ca>
Date: Tue, 24 Apr 2001 16:16:39 -0700
To: Richard Gooch <rgooch@ras.ucalgary.ca>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:59 PM -0600 4/24/01, Richard Gooch wrote:
>The plan I have (which I hope to get started on soon, now that I'm
>back from travels), is to change /dev/scsi/host# from a directory into
>a symbolic link to a directory called: /dev/bus/pci0/slot1/function0.
>Thus, to access a partition via location, one would use the path:
>/dev/bus/pci0/slot1/function0/bus0/target1/lun2/part3.

A minor PCI terminology point: PCI buses are subdivided into devices, not (necessarily) slots. So, for example, a multiple-device PCI card (say, two SCSI controllers) might have a PCI bridge creating a new bus, and two devices (not slots) on that bus. (It could alternatively be implemented as a single device with two functions,  given a dual-interface chip, but not necessarily.)

So a better name would be /dev/bus/pci0/dev1/fcn0/bus0/tgt1/lun2/part3 (taking the liberty of abbreviating some of the other names).

How, if at all, would RAID devices, using more than one physical device, or SCSI bus, or PCI card, fit into this naming scheme?


-- 
/Jonathan Lundell.
