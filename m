Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVADRhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVADRhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVADRhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:37:07 -0500
Received: from mail0.lsil.com ([147.145.40.20]:31377 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261802AbVADRd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:33:58 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CAD3@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, brking@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Tue, 4 Jan 2005 12:25:54 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Mon, 2005-01-03 at 18:02 -0500, Bagalkote, Sreenivas wrote:
>> o    Everybody understands that as long as the SCSI 
>scan/rescan is triggered
>> by 
>> the management app, there is no getting around knowing HCTL 
>mapping. The app
>> must know the HCTL quad of a logical drive.
>
>Actually, if that's all you're trying to do, what about
>
>echo '- - -' > /sys/class/scsi_host/host<n>/scan
>
>That'll trigger a rescan of the entire card and the device 
>will be found
>and added?
>

A minor point is that an application should ideally force scan only those
drives
that it has added. But more importantly, this will not help an application
to delete
the drives. Correct?

Sreenivas
