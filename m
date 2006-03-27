Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWC0PYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWC0PYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWC0PYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:24:47 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:49931 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751084AbWC0PYr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:24:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060327145501.34766.qmail@web30606.mail.mud.yahoo.com>
x-originalarrivaltime: 27 Mar 2006 15:24:43.0165 (UTC) FILETIME=[92911CD0:01C651B2]
Content-class: urn:content-classes:message
Subject: Re: Detecting I/O error and Halting System
Date: Mon, 27 Mar 2006 10:24:42 -0500
Message-ID: <Pine.LNX.4.61.0603271017580.16388@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Detecting I/O error and Halting System
Thread-Index: AcZRspKaTdY6XUTqQn6zqUNXhaw0Yw==
References: <20060327145501.34766.qmail@web30606.mail.mud.yahoo.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "zine el abidine Hamid" <zine46@yahoo.fr>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2006, zine el abidine Hamid wrote:

> Hi everybody,
>
> I have I/O error which occurs on servers based on a
> VIA VT82C686 chipset and I have to prevent or stop the
> error. I spent a lot time for searching solutions to
> stop the error but I don't found anything, So I want
> to write a module which will surveil the HDD and
> stops the system after sending a mail.
>
> I read a lot of documents about kernel and writting
> modules but I don't know how to start...? Help,
> please.
>
> I'm not closed to others solutions (like smartd, or
> writting classical programms)
>
> Best regards.
>
> Zine
>
> PS : this are errors du to VIA chipset; if anyone
> knows wath appens...?
>
>
> Feb 12 04:46:03 porte_de_clignancourt_nds_b kernel:
> hda: timeout waiting for DMA
> Feb 12 04:46:06 alesia_nds_b ucd-snmp[812]: Connection
> from 104.25.3.11
> Feb 12 04:46:23 porte_de_clignancourt_nds_b kernel:
> ide_dmaproc: chipset supported ide_dma_timeout func
> only: 14
> Feb 12 04:46:23 porte_de_clignancourt_nds_b kernel:
> hda: status timeout: status=0xd0 { Busy }      adapter
> disque annonce un status busy du DMA
> Feb 12 04:46:23 porte_de_clignancourt_nds_b kernel:
> hda: drive not ready for command
> Feb 12 04:46:23 porte_de_clignancourt_nds_b
> ucd-snmp[813]: Connection from 104.1.3.11
> Feb 12 04:46:23 porte_de_clignancourt_nds_b
> ucd-snmp[813]: Connection from 104.1.3.11
> Feb 12 04:46:23 porte_de_clignancourt_nds_b last
> message repeated 3 times
> Feb 12 04:46:23 porte_de_clignancourt_nds_b kernel:
> ide0: reset: success
> Feb 12 10:22:38 porte_de_clignancourt_nds_b kernel:
> hda: timeout waiting for DMA
> Feb 12 10:24:46 porte_de_clignancourt_nds_b kernel:
> ide_dmaproc: chipset supported ide_dma_timeout func
> only: 14
> Feb 12 10:24:46 porte_de_clignancourt_nds_b kernel:
> hda: status timeout: status=0xd0 { Busy }
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: drive not ready for command
> Feb 12 10:24:47 porte_de_clignancourt_nds_b
> ucd-snmp[813]: Connection from 104.1.3.11
> Feb 12 10:24:47 porte_de_clignancourt_nds_b last
> message repeated 4 times
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> ide0: reset timed-out, status=0x80
> le premier reser de ide0 est en échec
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: status timeout: status=0x80 { Busy }
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: drive not ready for command
> Feb 12 10:24:47 porte_de_clignancourt_nds_b
> ucd-snmp[813]: Connection from 104.1.3.11
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> ide0: reset: success
>
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: irq timeout: status=0xd0 { Busy }
>
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: DMA disabled
>
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> ide0: reset timed-out, status=0x80
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: status timeout: status=0x80 { Busy }
> nouvel échec de reset
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> hda: drive not ready for command
> Feb 12 10:24:47 porte_de_clignancourt_nds_b kernel:
> ide0: reset: success
>
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> ide0: reset timed-out, status=0x80
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> hda: status timeout: status=0x80 { Busy }
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> hda: drive not ready for command
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> ide0: reset timed-out, status=0x80
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> end_request: I/O error, dev 03:02 (hda), sector 102263
> Feb 12 13:45:38 porte_de_clignancourt_nds_b syslogd:
> /var/log/maillog: Input/output error
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> end_request: I/O error, dev 03:02 (hda), sector 110720
> Feb 12 13:45:38 porte_de_clignancourt_nds_b kernel:
> end_request: I/O error, dev 03:02 (hda), sector 110728
>
>

Maybe you should just fix the problem rather than attempting
to work around it! The problem is that that you system has
difficulty communicating with a hard disk. This is caused
by either:

(1)	Bad hard disk.
(2)	Bad cable.
(3)	Improper configuration of one or more disks.

Since a reset timed out, it is likely that one of the disks
that share the same cable is defective, not necessarily /dev/hda
if you have another drive on the same cable. If you have only
one drive per cable (or only one drive), it is likely that
/dev/hda is (or becomes defective). Note that the disk can
fail if it gets too hot.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
