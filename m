Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUAJPII (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUAJPII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:08:08 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:7430 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S265205AbUAJPIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:08:04 -0500
Message-ID: <40001661.90705@kolumbus.fi>
Date: Sat, 10 Jan 2004 17:12:33 +0200
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tom.l.nguyen@intel.com, len.brown@intel.com
CC: linux-kernel@vger.kernel.org
Subject: PCI vector and ACPI
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 10.01.2004 17:10:11,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 10.01.2004 17:09:19,
	Serialize complete at 10.01.2004 17:09:19
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be some bad interaction between PCI VECTOR 
(use_pci_vector()) and ACPI PRTs. Namely, both mp_parse_prt() and 
pcibios_fixup_irqs() do the IO_APIC_VECTOR() translation on irq, the 
result being  IO_APIC_VECTOR(IO_APIC_VECTOR(irq)). I wonder if this is 
the cause of some bug reports with acpi and pci vector? Maybe 
mp_parse_prt() should not do the irq->vector translation?

--Mika


