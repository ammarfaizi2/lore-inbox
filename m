Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbVIPH3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbVIPH3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbVIPH3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:29:05 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:18118 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161105AbVIPH3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:29:03 -0400
To: Sergey Panov <sipan@sipan.org>
Cc: Douglas Gilbert <dougg@torque.net>, Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-scsi-owner@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Matthew Wilcox <matthew@wil.cx>, Patrick Mansfield <patmans@us.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process	(end
 devices)
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
From: Andreas Herrmann <AHERRMAN@de.ibm.com>
X-MIMETrack: S/MIME Sign by Notes Client on Andreas Herrmann/Germany/IBM(Release 5.0.11
  |July 24, 2002) at 16.09.2005 09:26:09,
	Serialize by Notes Client on Andreas Herrmann/Germany/IBM(Release 5.0.11  |July
 24, 2002) at 16.09.2005 09:26:09,
	Serialize complete at 16.09.2005 09:26:09,
	S/MIME Sign failed at 16.09.2005 09:26:09: The cryptographic key was not
 found,
	Serialize by Router on D12ML065/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 16/09/2005 09:28:55,
	Serialize complete at 16/09/2005 09:28:55
Message-ID: <OF93511537.D7B47A05-ONC125707D.00728836-C125707E.0028DAC3@de.ibm.com>
Date: Fri, 16 Sep 2005 09:28:54 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.2005 07:22 Sergey Panov <sipan@sipan.org> wrote:
> On Tue, 2005-09-13 at 15:25 -0700, Patrick Mansfield wrote:

> > I think the only HBA's today that can handle an 8 byte lun are lpfc 
and
> > iscsi (plus new SAS ones).

> I am not aware of any SCSI/FC/SAS/etc hardware which uses more then just
> first two bytes, but all drivers I looked at to proper bytes
> rearrangement for those two bytes, and, as a result they do support 00b
> and 01b addressing modes. 

In certain configurations IBM's DS8000 uses 2nd level addressing with
flat space addressing method (01b). Thus ending up with 8 byte LUNs
where the first 4 bytes are really used, e.g. 40:ab:40:cd:00:00:00:00.
This allows to address more than 0x3fff LUNs. But I don't know whether
that many LUNs can be configured in practice.

BTW, zfcp really handles 8 byte LUNs using "unsigned long long" on
big (endian) iron ;-)
(However LUNs have to be configured via sysfs - no LUN scanning
supported at the moment ;-(


Regards,

Andreas
