Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbTB1Ty5>; Fri, 28 Feb 2003 14:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268137AbTB1Ty5>; Fri, 28 Feb 2003 14:54:57 -0500
Received: from fmr02.intel.com ([192.55.52.25]:18912 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268133AbTB1Ty4>; Fri, 28 Feb 2003 14:54:56 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A1B9@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>, Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: ACPI request/release generic address
Date: Fri, 28 Feb 2003 08:49:44 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Can you define a generic address?
> 
> IIRC, ACPI needs some work in this area.
> 
> If the "generic address" is host RAM, that's easy.
> If the generic address is PIO address, that's mostly easy.
> If the generic address is MMIO address, that takes a bit of care with
> mapping, and I'm not sure ACPI gets it right in these cases.

The Generic Address Structure (GAS) is basically a 64 bit address and a
type field. The type can be:

System memory
System IO
PCI Config space
Embedded Controller
SMBus
Functional fixed hardware

I don't think this will very easily handle a clean request/release API.
Corey, what is the specific table you are concerned with? At least with
the GASes ACPI uses internally, they point to resource regions already
marked as used via other means (e820 or _CRS, for example.)

Regards -- Andy
