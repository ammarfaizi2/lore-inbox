Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVGYGYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVGYGYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVGYGYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 02:24:31 -0400
Received: from dizz-a.telos.de ([212.63.141.211]:17569 "EHLO mail.telos.de")
	by vger.kernel.org with ESMTP id S261526AbVGYGYW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 02:24:22 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Stripping in module
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Mon, 25 Jul 2005 08:23:49 +0200
Message-ID: <809C13DD6142E74ABE20C65B11A24398020882@www.telos.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stripping in module
Thread-Index: AcWQ4WsynMBVnWr4Sh+4D/jY5pOl9w==
From: "Budde, Marco" <budde@telos.de>
To: <linux-kernel@vger.kernel.org>
X-telosmf: done
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

at the moment I am packaging a Linux module as an RPM archive.

Therefor I would like to remove some of the not exported/needed
symbols (like e.g. static functions or constants) from the
Linux module.

What is the best way to do this with v2.6.

I have tried e.g. to remove all symbols starting with "telos"
from the module like this (after kbuild):

  strip -w -K '!telos*' -K 'telosi2c_usb_driver' telosi2c_linux.ko

When I try to load such a module, insmod dies with a segmentation
fault or the complete kernel dies (with "invalid operand: 0000").
What is the reason for this problem?

What is the correct way using kbuild to remove some symbols?

cu, Marco

