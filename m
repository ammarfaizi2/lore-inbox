Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032117AbWLGMVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032117AbWLGMVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032114AbWLGMVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:21:00 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:37319 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032103AbWLGMU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:20:59 -0500
Message-ID: <45780726.8010107@garzik.org>
Date: Thu, 07 Dec 2006 07:20:54 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org> <4574B004.6030606@us.ibm.com>
In-Reply-To: <4574B004.6030606@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> The Quantum GoVault SATAPI removable disk device returns ATA_ERR in
> response to a REPORT LUNS packet.  If this happens to an ATAPI device
> that is attached to a SAS controller (this is the case with sas_ata),
> the device does not load because SCSI won't touch a "SCSI device"
> that won't report its LUNs.  Since most ATAPI devices don't support
> multiple LUNs anyway, we might as well fake a response like we do for
> ATA devices.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

Seems sane to me, but I would like additional comment/testing/etc. 
before applying...


