Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVADApq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVADApq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVADAeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:34:10 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:46035 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261970AbVACXlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:41:31 -0500
Subject: RE: How to add/drop SCSI drives from within the driver?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, brking@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CACD@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E570230CACD@exa-atlanta>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 17:40:10 -0600
Message-Id: <1104795610.5506.75.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 18:02 -0500, Bagalkote, Sreenivas wrote:
> o    Everybody understands that as long as the SCSI scan/rescan is triggered
> by 
> the management app, there is no getting around knowing HCTL mapping. The app
> must know the HCTL quad of a logical drive.

Actually, if that's all you're trying to do, what about

echo '- - -' > /sys/class/scsi_host/host<n>/scan

That'll trigger a rescan of the entire card and the device will be found
and added?

Then, if you simply publish your LD number as an extra parameter of the
device, you can look through /sys to find it.

James


