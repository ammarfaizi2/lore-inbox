Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261760AbSJCRLI>; Thu, 3 Oct 2002 13:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261759AbSJCRLI>; Thu, 3 Oct 2002 13:11:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:47257 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261758AbSJCRLG>; Thu, 3 Oct 2002 13:11:06 -0400
Date: Thu, 3 Oct 2002 10:17:38 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: akpm@digeo.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       dougg@gear.torque.net
Subject: Re: 2.4.39 "Sleeping function called from illegal context at slab.c:1374"
Message-ID: <20021003171738.GA1106@beaverton.ibm.com>
Mail-Followup-To: akpm@digeo.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, dougg@gear.torque.net
References: <3D99885B.533C320D@aitel.hist.no> <3D99EF62.3A3E6932@digeo.com> <20021001215907.GA8273@midgaard.us> <3D9A207A.14BFF440@digeo.com> <20021002162443.GA1317@beaverton.ibm.com> <20021002184437.GA17474@midgaard.us> <20021002212122.GF1317@beaverton.ibm.com> <20021002235349.GA20442@midgaard.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002235349.GA20442@midgaard.us>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas,
	I noticed a problem with the scsi_error.c update the I made to
	2.5.40. There is a typo in the the tur check on error handling.
	I tested the patch yesterday and it is recovering better on
	faults. 

	I do not know if it will fix your problem, but it might be worth
	a try.
	
	I will send it to you in bit I am in the process of
	rolling it and other patches that depend on it up.


Andreas Boman [aboman@nerdfest.org] wrote:
> * Mike Anderson (andmike@us.ibm.com) wrote:
> > Andreas,
> > 	Here is the updated patch.
> > 
> 
> Yep, no more warnings on modprobe sg. Unfortenuately the box still hangs after 
> modprobe ide-scsi:
> 
>  scsi1 : SCSI host adapter emulation for IDE ATAPI devices
>  scsi_eh_offline_sdevs: Device set offline - notready or command retry failedafter error recovery: host1 channel 0 id 0 lun 0
>    Vendor:           Model:                   Rev:     
>    Type:   Direct-Access                      ANSI SCSI revision: 00
>  hda: lost interrupt
>  ide-scsi: CoD != 0 in idescsi_pc_intr
>  hda: DMA disabled
>  hda: ATAPI reset complete
> 
> 
> andreas
-andmike
--
Michael Anderson
andmike@us.ibm.com

