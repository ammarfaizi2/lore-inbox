Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVJUMcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVJUMcv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 08:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVJUMcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 08:32:51 -0400
Received: from mail0.lsil.com ([147.145.40.20]:39162 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S964915AbVJUMcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 08:32:50 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CD291@exa-atlanta>
From: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>, dougg@torque.net
Cc: andrew.patterson@hp.com, Luben Tuikov <luben_tuikov@adaptec.com>,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: RE: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally a
	ttached PHYs)
Date: Fri, 21 Oct 2005 08:32:25 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Jeff Garzik wrote:
>> Do you know where there are some clear guidelines on the use of 
>> pointers in a structure passed to an ioctl to lessen (or bypass) 
>> 32<->64 compat ioctl thunking?
>
>Its impossible.  If you pass pointers, you need to thunk.  
>(Not even passing pointers via sysfs can avoid this.)  
>Consider running a 32-bit app (with 32-bit pointers and 32-bit 
>ABI) on a 64-bit kernel.

The drivers/scsi/megaraid/megaraid_mm.c simply calls regular ioctl
from within the compat_ioctl, though it does copy to and from the
userland pointers. This is done by adding appropriate padding.

Sincerely,
Sreenivas
