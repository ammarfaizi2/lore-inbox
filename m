Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUIWWJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUIWWJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUIWWG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:06:27 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:27411 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S267450AbUIWWFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:05:48 -0400
Message-ID: <41534989.3070001@kolumbus.fi>
Date: Fri, 24 Sep 2004 01:09:13 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
CC: anil.s.keshavamurthy@intel.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][4/4] Add NUMA node handling to the container driver
References: <20040920092520.A14208@unix-os.sc.intel.com>	<20040920094719.H14208@unix-os.sc.intel.com>	<20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com> <20040924013642.00003b08.tokunaga.keiich@jp.fujitsu.com>
In-Reply-To: <20040924013642.00003b08.tokunaga.keiich@jp.fujitsu.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 24.09.2004 01:06:53,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 24.09.2004 01:07:45,
	Serialize complete at 24.09.2004 01:07:45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keiichiro Tokunaga wrote:

>Name: container_for_numa.patch
>Status: Tested on 2.6.9-rc2
>Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
>Description:
>Add NUMA node handling to the container driver.
>
>Thanks,
>Keiichiro Tokunaga
>---
>  
>

>@@ -198,6 +208,7 @@ container_device_add(struct acpi_device 
> 	if (acpi_bus_add(device, pdev, handle, ACPI_BUS_TYPE_DEVICE)) {
> 		return_VALUE(-ENODEV);
> 	}
>+	container_numa_add((*device)->handle);
>  
>
Maybe that should be :

container_numa_add(phandle);
 
instead? Device is the child at this point.

--Mika



