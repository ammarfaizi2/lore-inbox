Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUEEQ2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUEEQ2k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbUEEQ2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:28:35 -0400
Received: from pat.qlogic.com ([198.70.193.2]:54571 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S264725AbUEEQ2W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:28:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: qla2300 at only 1 GBit on kernel 2.6.5
Date: Wed, 5 May 2004 09:27:10 -0700
Message-ID: <B179AE41C1147041AA1121F44614F0B0DD0114@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: qla2300 at only 1 GBit on kernel 2.6.5
Thread-Index: AcQyveBZeSokbcWYS22NZCyONlmCoQ==
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Jan-Frode Myklebust" <janfrode@parallab.uib.no>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Cc: "Moore, Eric Dean" <Emoore@lsil.com>
X-OriginalArrivalTime: 05 May 2004 16:26:27.0906 (UTC) FILETIME=[B7527A20:01C432BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On , linux-scsi-owner@vger.kernel.org wrote:

> This seems to be working fine with the RedHat 2.4.21-9.0.1.ELsmp
> kernel,
>

How are you verifying that the 2.4 driver is coming-up in 2Gig rather
than 1gig?  Do you have an analyzer running between the HBA and
storage device?  Or, as you mentioned later in the email when testing
the 8.x driver, did you force 2gig at the RAID box and reload the
2.4 driver?

> but when I try running on the vanilla 2.6.5 kernel, it only
> operates in 1 GB mode.
>

Yes, the 8.x series driver started to display the connection speed
during a loop_up event.

	qla2300 0000:01:05.0: LOOP UP detected (1 Gbps).

> The HBA is connected to a Infortrend
> SATA/RAID box.
>

Which model?  Actually, looking ahead, I can see you are running an

	Vendor: IFT       Model: A16F-G1A2         Rev: 334A

Of the three FC-SATA RAID boxes that are advertised, only the
A16F-J1210-G1 model mentions support for 'full-duplex 2Gb FC-AL'.

> If I try forcing the connection to 2 GBit from the
> Infortrend, I get an error saying 'Cable unplugged' when loading the
> qla2300 module on 2.6.5. 
> 

Hmm, could you go into the BIOS utility (ctrl-q during boot) and check
the 'Data Rate' settings for the HBA?  What is the value set to --
auto/1gb/2gb?  If it is set to auto, could you set it to 2gb and retry
the test.

Regards,
Andrew Vasquez
QLogic Corporation
