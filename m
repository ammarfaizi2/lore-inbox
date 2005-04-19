Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVDSFGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVDSFGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 01:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVDSFGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 01:06:13 -0400
Received: from emulex.emulex.com ([138.239.112.1]:209 "EHLO emulex.emulex.com")
	by vger.kernel.org with ESMTP id S261320AbVDSFFq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 01:05:46 -0400
From: James.Smart@Emulex.Com
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Fibre Channel state of the union
Date: Tue, 19 Apr 2005 01:05:35 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C20628C1@xbl3.ad.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fibre Channel state of the union
Thread-Index: AcVELRm9jW3XZHFARt2r3PFGuDchRgAb/lEw
To: <hch@lst.de>, <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

FYI - Emulex is committed to completing the effort for creating a vendor-agnostic open-source hbaapi library for linux, including the thornier issues of performing CT passthru and RNID functionality.  As soon as the library exists, an open-source SMI-S provider would become available as well.

-- James


> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org
> [mailto:linux-scsi-owner@vger.kernel.org]On Behalf Of 
> Christoph Hellwig
> Sent: Monday, April 18, 2005 11:40 AM
> To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Fibre Channel state of the union
> 
> 
> 
> With the upcoming merge of the current SCSI development 
> branch (probably
> after the 2.6.12 release), Linux will have more advanced Fibre Channel
> support than any currently available operating system.
> 
> The new Fibre Channel (FC) transport class offers two major advantages
> over traditional standalone drivers:
> 
>  (1) It provides an easy to use library to deal with most 
> aspects of FC
>      remote port management and its integration into SAM and the Linux
>      SCSI layer.
> 
>       - a remote port object that sits between the host and the target
> 	in the Linux SCSI layer object model
>       - support for remote port based LUN scanning, including live
> 	rescanning on fabric topology changes and stable remove port to
> 	SCSI target id mappings
>       - a queue freeze facility to handle temporary cable 
> unplugs without
> 	generating I/O errors
>      
>  (2) a common userspace interface to transport specific and management
>      information in sysfs.  The information provided is based 
> on a sane
>      subset of the SNIA HBA API specification.
>  
> This reduces the burden of writing and maintaining an FC HBA driver
> substantially, for example the recent conversion of the 
> qla2xxx driver to
> use these facilities removes over 3000 lines of code (about 
> 1/5 of the overall
> driver size) while adding new features and a userspace 
> management interface.
> The FC transport class thus allows hardware vendors to concentrate on
> interfacing with the hardware and support their unique 
> features, freeing
> them from the burden of reimplementing basic infrastructure 
> in every driver
> and designing ad hoc management interfaces.
> 
> We now have two drivers supporting this infrastructure fully:
> 
>   - qla2xxx for Qlogic 2100/2200/23xx HBAs
>   - lpfc for all Emulex SLI2 HBAs
> 
> Two drivers for modern hardware don't fully use this 
> infrastructure yet,
> but we are working with the maintainers and expect the drivers to be
> updated to take advantage of the new FC transport class soon.
> 
>   - zfcp for the Fibre Channel attachment on the IBM zSeries 
> mainframes
>   - mptfusion for the LSI "Fusion" 909/919(X)/929(X) HBAs
> 
> Still missing is an Open Source tool application utilizing our APIs.
> The currently available proprietary applications are 
> inflexible, available
> only for very few of the architectures supported by Linux, and tied to
> specific HBAs. The common API and hardware independence 
> provide a great
> opportunity for the Hardware vendors to collaborate on a 
> single Open Source
> management application and leverage the cost savings of an 
> open development
> method.
> 
> We are also looking forward to a bridge from the Linux
> management interfaces to the "industry-standard" SNIA HBA API,
> allowing various management applications to work out of the 
> box with our
> stack.
> 
> To make these new features available to Enterprise users and 
> reduce the
> fragmentation in driver and management space we will be 
> working with the
> major players in the Storage Industry and the Linux 
> Distribution vendors
> to support and certify this stack in the near future.
> 
> Special thanks go to Emulex and James Smart in particular for 
> implementing
> the majority of the new Fibre Channel transport class.  We 
> also want to
> thank Andrew Vasquez at Qlogic for providing valuable input on the
> transport class design and for updating the qla2xx driver to 
> use the new
> facilities quickly.
> 
> The Linux SCSI community plans to provide a similar framework for
> Serial Attached SCSI (SAS) transports in the near future.
> 
> 
> Thanks to Arjan van de Ven, Peter Jones, Randy Dunlap, Rik van Riel,
> Nikita Danilov and James Bottomley for reviewing this document and
> suggesting various improvements.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
