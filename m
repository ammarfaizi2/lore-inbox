Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264959AbUFGR7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbUFGR7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 13:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUFGR7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 13:59:05 -0400
Received: from fmr06.intel.com ([134.134.136.7]:11144 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264959AbUFGR7A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 13:59:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] 2.6.6 memory allocation checks in drivers/pci/hotplug/shpchprm_acpi.c
Date: Mon, 7 Jun 2004 10:56:54 -0700
Message-ID: <468F3FDA28AA87429AD807992E22D07E01351A46@orsmsx408>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.6 memory allocation checks in drivers/pci/hotplug/shpchprm_acpi.c
Thread-Index: AcRMuBWhiHSa+VIESZGEHuJMcZFS6QAABAZg
From: "Sy, Dely L" <dely.l.sy@intel.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <greg@kroah.com>
Cc: "Yury Umanets" <torque@ukrpost.net>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Jun 2004 17:56:57.0212 (UTC) FILETIME=[D31293C0:01C44CB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Luiz,

I sent out the patch to Greg last week and he'll apply it.

Thanks,
Dely

-----Original Message-----
From: Luiz Fernando N. Capitulino
[mailto:lcapitulino@prefeitura.sp.gov.br] 
Sent: Monday, June 07, 2004 10:36 AM
To: Randy.Dunlap
Cc: Yury Umanets; akpm@osdl.org; linux-kernel@vger.kernel.org; Sy, Dely
L
Subject: Re: [PATCH] 2.6.6 memory allocation checks in
drivers/pci/hotplug/shpchprm_acpi.c


 Hello Randy, Yury,

Em Sun, Jun 06, 2004 at 10:51:06AM -0700, Randy.Dunlap escreveu:

| On Sun, 06 Jun 2004 19:20:51 +0300 Yury Umanets wrote:
| 
| | Adds memory allocation checks in acpi_get__hpp()
| | 
| |  ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c |    2
++
| |  1 files changed, 2 insertions(+)
| | 
| | Signed-off-by: Yury Umanets <torque@ukrpost.net>
| | 
| | diff -rupN ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c
| | ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c
| | --- ./linux-2.6.6/drivers/pci/hotplug/shpchprm_acpi.c	Mon May
10
| | 05:32:28 2004
| | +++ ./linux-2.6.6-modified/drivers/pci/hotplug/shpchprm_acpi.c
Wed Jun 
| | 2 14:28:07 2004
| | @@ -218,6 +218,8 @@ static void acpi_get__hpp ( struct acpi_
| |  	}
| |  
| |  	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
| | +	if (!ab->_hpp)
| | +		goto free_and_return;
| |  	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
| |  
| |  	ab->_hpp->cache_line_size	= nui[0];
| | 
| | -- 
| 
| All other failure paths in this function use err() to inform the
| console about what's happening...  so flip a coin, I guess:
| add a message or say that ACPI already has too many messages.  :(

 I sent the same patch for this some weeks ago. Dely accepted, but it
was
not applyed. Don't know why.


-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
