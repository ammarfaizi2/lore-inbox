Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWFAO3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWFAO3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWFAO3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:29:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45536 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750992AbWFAO3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:29:21 -0400
Subject: Re: PROBLEM: BAD RAM SIZE DETECTION ON DELL POWER EDGE SC420
From: Arjan van de Ven <arjan@infradead.org>
To: cyril canovas <cyril@egnx.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606011621.07881.cyril@egnx.com>
References: <200606011621.07881.cyril@egnx.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 16:29:19 +0200
Message-Id: <1149172159.3115.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000d768cc00 (usable)

and ...
>  BIOS-e820: 00000000d768cc00 - 00000000d768ec00 (ACPI NVS)
>  BIOS-e820: 00000000d768ec00 - 00000000d7690c00 (ACPI data)
>  BIOS-e820: 00000000d7690c00 - 00000000d8000000 (reserved)
>  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
>  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
>  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
... this is where your memory is going. The bios seems to have reserved
it in part for itself, and in part for PCI mmio space...
(which is required to have pci at all). Some machines remap this
quarter-to-half a gig (half on your machine) to above the 4Gb mark.
Your machine does not.



