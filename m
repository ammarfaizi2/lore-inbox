Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVAGEpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVAGEpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 23:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVAGEpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 23:45:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:51448 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261228AbVAGEpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 23:45:34 -0500
Subject: Re: SCSI aic7xxx driver: Initialization Failure over a kdump reboot
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <20050106195043.4b77c63e.akpm@osdl.org>
References: <1105014959.2688.296.camel@2fwv946.in.ibm.com>
	 <1105013524.4468.3.camel@laptopd505.fenrus.org>
	 <20050106195043.4b77c63e.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1105075645.2688.363.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jan 2005 10:57:25 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> yes, that's exactly what e100 was doing on my laptop last month.  Fixed
> that by arranging for the NIC to be reset before the call to
> pci_set_master().
> 
> I expect the adaptec driver could be fixed by calling ahc_reset() from a
> strategic place in either ahc_linux_pci_dev_probe() or in the shutdown
> handler.  

> (Does the crashdump code call shutdown handlers?  Sounds like a
> bad idea...)
> 

No. Crash dump code does not call shutdown handlers...

Thanks
Vivek


