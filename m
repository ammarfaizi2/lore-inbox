Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268652AbUJUGCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268652AbUJUGCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUJUF7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:59:15 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:27914 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S270259AbUJUF50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:57:26 -0400
Message-ID: <417750B6.7000409@kolumbus.fi>
Date: Thu, 21 Oct 2004 09:01:26 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Li Shaohua <shaohua.li@intel.com>
CC: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Adam Belay <ambx1@neo.rr.com>, Matthieu <castet.matthieu@free.fr>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 4/5]ACPI PNP driver
References: <1098327568.6132.226.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1098327568.6132.226.camel@sli10-desk.sh.intel.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 21.10.2004 08:58:43,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 21.10.2004 08:59:28,
	Serialize complete at 21.10.2004 08:59:28
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Li Shaohua wrote:

>Hi,
>This patch provides an ACPI based PNP driver. It is based on Matthieu
>Castet's original work. With this patch, legacy device drivers (floppy
>ACPI driver, COM ACPI driver, and ACPI motherboard driver) which
>directly use ACPI can be removed, since now we have unified PNP
>interface for legacy devices.
>
>Thanks,
>Shaohua
>
>Signed-off-by: Li Shaohua <shaohua.li@intel.com>
>
>The patch depends on previous 3 patches.
>
>--- 2.6/drivers/pnp/isapnp/Kconfig.stg3	2004-10-18 17:34:17.591712040
>+0800
>+++ 2.6/drivers/pnp/isapnp/Kconfig	2004-10-18 17:36:19.173228840 +0800
>  
>
Are you supposed to list here _every_ device to which not to bind? Is 
this feasible? Maybe take another approach and bind to the "default" 
acpi pnp driver if no specific driver found ?

+static char excluded_id_list[] =
+	"PNP0C0A," /* Battery */
+	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
+	"PNP0C09," /* EC */
+	"PNP0C0B," /* Fan */
+	"PNP0A03," /* PCI root */
+	"PNP0C0F," /* Link device */
+	"PNP0000," /* PIC */
+	"PNP0100," /* Timer */
+	;



---Mika

