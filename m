Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUAJPF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUAJPF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:05:29 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:61701 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S265193AbUAJPFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:05:23 -0500
Message-ID: <400015BE.6080500@kolumbus.fi>
Date: Sat, 10 Jan 2004 17:09:50 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nguyen@vger.kernel.org, Tom@vger.kernel.org, L@vger.kernel.org,
       len.brown@intel.con
CC: linux-kernel@vger.kernel.org
Subject: PCI vector and ACPI
References: <C7AB9DA4D0B1F344BF2489FA165E50240154170D@orsmsx404.jf.intel.com>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E50240154170D@orsmsx404.jf.intel.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 10.01.2004 17:07:27,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 10.01.2004 17:06:38,
	Serialize complete at 10.01.2004 17:06:38
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be some bad interaction between PCI VECTOR 
(use_pci_vector()) and ACPI PRTs. Namely, both mp_parse_prt() and 
pcibios_fixup_irqs() do the IO_APIC_VECTOR() translation on irq, the 
result being  IO_APIC_VECTOR(IO_APIC_VECTOR(irq)). I wonder if this is 
the cause of some bug reports with acpi and pci vector? Maybe 
mp_parse_prt() should not do the irq->vector translation?

--Mika


