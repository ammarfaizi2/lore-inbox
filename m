Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVADRqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVADRqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVADRqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:46:07 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:40909 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261726AbVADRpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:45:49 -0500
Subject: RE: How to add/drop SCSI drives from within the driver?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, brking@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CAD3@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570230CAD3@exa-atlanta>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 11:42:32 -0600
Message-Id: <1104860553.5327.46.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 12:25 -0500, Bagalkote, Sreenivas wrote:
> A minor point is that an application should ideally force scan only those
> drives

Yes, it's a bit overkill, but it would work ... it's not like
reconfiguration is something you do every day.

> that it has added. But more importantly, this will not help an application
> to delete
> the drives. Correct?

Well, no, I think that would work under this scheme, too:  to delete a
drive, it must already exist, so if you've published the logical number
in sysfs, you can easily find it by logical ID and delete it by host
channel, pun and lun.

James


