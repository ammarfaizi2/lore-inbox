Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVGYQPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVGYQPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 12:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVGYQPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 12:15:13 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:15227 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S261339AbVGYQOj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 12:14:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Stripping in module
Date: Mon, 25 Jul 2005 09:14:46 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C33D2880@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stripping in module
thread-index: AcWQ4WsynMBVnWr4Sh+4D/jY5pOl9wAUmUXw
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Budde, Marco" <budde@telos.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jul 2005 16:14:39.0570 (UTC) FILETIME=[F55B7B20:01C59133]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the best you can do is
strip -R .note -R .comment --strip-unneeded.

 If you go for more, module might not be loaded/initialized properlly

Aleks.

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Budde, Marco
>Sent: Sunday, July 24, 2005 11:24 PM
>To: linux-kernel@vger.kernel.org
>Subject: Stripping in module
>
>Hi,
>
>at the moment I am packaging a Linux module as an RPM archive.
>
>Therefor I would like to remove some of the not exported/needed
>symbols (like e.g. static functions or constants) from the
>Linux module.
>
>What is the best way to do this with v2.6.
>
>I have tried e.g. to remove all symbols starting with "telos"
>from the module like this (after kbuild):
>
>  strip -w -K '!telos*' -K 'telosi2c_usb_driver' telosi2c_linux.ko
>
>When I try to load such a module, insmod dies with a segmentation
>fault or the complete kernel dies (with "invalid operand: 0000").
>What is the reason for this problem?
>
>What is the correct way using kbuild to remove some symbols?
>
>cu, Marco
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
