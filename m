Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVJRRx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVJRRx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 13:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVJRRx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 13:53:27 -0400
Received: from spirit.analogic.com ([204.178.40.4]:2317 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751109AbVJRRx1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 13:53:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43553205.9010006@rhla.com>
References: <43553205.9010006@rhla.com>
X-OriginalArrivalTime: 18 Oct 2005 17:53:18.0212 (UTC) FILETIME=[D2415440:01C5D40C]
Content-class: urn:content-classes:message
Subject: Re: Reduce idle connection timeout
Date: Tue, 18 Oct 2005 13:53:17 -0400
Message-ID: <Pine.LNX.4.61.0510181345020.1352@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reduce idle connection timeout
Thread-Index: AcXUDNJgPJg61eZ1ReSCsJNqfcYaoA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: =?iso-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@rhla.com>
Cc: <kernelnewbies@nl.linux.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Oct 2005, [iso-8859-1] Márcio Oliveira wrote:

> Hi,
>
>   Anybody knows how can I reduce the idle connections (TCP, UDP, ...)
> timeout in Linux systems?
>
> Thanks in advance!
>
> Marcio

Well UDP doesn't have a timeout because it's connectionless, but
TCP (stream sockets) do. Look in /proc/sys/net/ipv4 and see if you
can find what you want. You probably are looking for tcp_fin_timeout
if you are concerned about what `netstat -c` shows after a disconnection.
FYI, If you are just trying to reuse an address, you don't have
to muck with kernel parameters, just `man setsockopt` SO_REUSEADDR, etc.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
