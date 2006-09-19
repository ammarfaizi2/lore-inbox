Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWISUcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWISUcF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbWISUcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:32:04 -0400
Received: from mail0.lsil.com ([147.145.40.20]:64746 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751141AbWISUcB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:32:01 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Multi-Initiator SAS
Date: Tue, 19 Sep 2006 14:31:57 -0600
Message-ID: <664A4EBB07F29743873A87CF62C26D7032CDD4@NAMAIL4.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Multi-Initiator SAS
Thread-Index: AcbcJ60Mi3VyC2VLRHSYXy4TWv+poQAAlfvg
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>, <dougg@torque.net>
Cc: <linux-scsi@vger.kernel.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2006 20:31:58.0244 (UTC) FILETIME=[A76EEE40:01C6DC2A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:

> Douglas Gilbert wrote:
> 
> > With the mptsas driver you can use smp_utils to look
> > at that expander via /dev/mptctl ('modprobe mptctl' first).
> > To get an overview of what the expander sees, try:
> >  # smp_discover -mb /dev/mptctl
> 
> Unfortunately, I see this:
> 


You need to pass the sas address of the expander.

./smp_discover --sa=sas_address /dev/mptctl

where sas_address can be found in
/sys/class/sas_device/expander-X:0/sas_address
