Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUBDMqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 07:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUBDMqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 07:46:38 -0500
Received: from mailin.radiomobil.cz ([62.141.0.149]:55045 "EHLO
	mailin.radiomobil.cz") by vger.kernel.org with ESMTP
	id S261522AbUBDMqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 07:46:36 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Subject: Problem with NUMA kernel on IBM xSeries 455 server
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: normal
Date: Wed, 4 Feb 2004 13:46:33 +0100
Message-ID: <6D2F48AA9477864682B4078EFF1BEAF1057F0B7D@RDMKSPE02.rdm.cz>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with NUMA kernel on IBM xSeries 455 server
thread-index: AcPrHOtPIjFSWlYnEditwgAMKUF1MA==
From: "Uher Marek" <Marek.Uher@t-mobile.cz>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Feb 2004 12:46:33.0858 (UTC) FILETIME=[EB774620:01C3EB1C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi all,

I have a problem with running Linux on my IBM xSeries 455 server (4 x Intel 
Xeon MP CPU 2.80GHz, 8 GB RAM). I have tried to compile kernel 2.6.2 with
Summit/EXA (IBM x440) NUMA support, high memory support (64GB), NUMA memory
allocation support, ACPI and ACPI NUMA support. When I have tried to make
bzImage I have got this messages:

drivers/built-in.o(.init.text+0x1751): In function `acpi_parse_slit': 
: undefined reference to `acpi_numa_slit_init'
drivers/built-in.o(.init.text+0x176d): In function `acpi_parse_processor_affinit
y':
: undefined reference to `acpi_numa_processor_affinity_init'
drivers/built-in.o(.init.text+0x1791): In function `acpi_parse_memory_affinity':
: undefined reference to `acpi_numa_memory_affinity_init'
drivers/built-in.o(.init.text+0x1850): In function `acpi_numa_init':
: undefined reference to `acpi_numa_arch_fixup'
make: *** [.tmp_vmlinux1] Error 1

Do you have any idea? I don't know what is wrong.

Thanks.

Marek
 --
Ing. Marek Uher
Linux System Specialist
Technology Division
T-Mobile Czech Republic a.s.
Evropska 178
160 67 Praha 6
Czech Republic
Mobile:	(+420) 603 400 728
Office:	(+420) 603 607 128
Fax:		(+420) 603 600 796
E-mail:	marek.uher@t-mobile.cz
Web:		http://www.t-mobile.cz/
 


---------- Disclaimer ----------
Informace obsa¾ené v tomto e-mailu jsou urèeny výluènì pro potøeby jeho adresáta. Text nebo pøílohy mohou obsahovat utajované informace, informace pova¾ované spoleèností T-Mobile za obchodní tajemství, pøípadnì jiné informace podléhající ochranì dle pøíslu¹ných právních pøedpisù. Pokud Vám tento e-mail byl omylem doruèen, zdr¾te se, prosím, jakékoli manipulace s textem èi pøílohami, jako je kopírování, pøesmìrování, zpøístupnìní dal¹í osobì a podobnì. O chybném doruèení informujte odesílatele a e-mail vèetnì pøíloh vyma¾te ze svého poèítaèe.
The information contained within this e-mail is intended only for the person or entity to which it is addressed. The text or attachments may contain confidential information, information considered a trade secret by T-Mobile or, as the case may be, other information subject to protection under the relevant legal regulations. If you receive this e-mail by mistake, please refrain from copying, forwarding or disclosing the text or attachments to other persons, etc. Inform the sender of the mistaken delivery and delete the e-mail, including all attachments, from your computer.

