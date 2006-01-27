Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWA0C0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWA0C0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 21:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbWA0C0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 21:26:45 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:57650 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030238AbWA0C0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 21:26:44 -0500
Date: Thu, 26 Jan 2006 20:25:28 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-reply-to: <5zc5f-6pi-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43D98498.9030505@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5yJ3h-6er-11@gated-at.bofh.it> <5yVQR-8bI-39@gated-at.bofh.it>
 <5yWah-99-29@gated-at.bofh.it> <5yWjN-Bl-13@gated-at.bofh.it>
 <5yWDl-111-23@gated-at.bofh.it> <5yWML-1ea-5@gated-at.bofh.it>
 <5zc5f-6pi-3@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> People like to run cdrecord -scanbus in order to find a list of usable devices.
> People like to see all SCSI devices in a single name space as they are all 
> using the same protocol for communication.

Except that the majority of CD writers today are NOT SCSI devices. They 
may use the MMC command set from SCSI for interface purposes, but they 
are on an ATA or USB bus. cdrecord tries to fabricate some kind of 
device numbering assigning SCSI-like bus and LUN numbers for the devices 
when such a numbering has no basis in any kind of reality.

We have all SCSI devices in a single namespace, that is what /dev is 
for. That is the name that the system/kernel provides for applications 
to use, and that is what the application should use, not some kind of 
bizarre invented numbering scheme built on top of that.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

