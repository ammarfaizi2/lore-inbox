Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWEYQkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWEYQkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWEYQkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:40:15 -0400
Received: from xenotime.net ([66.160.160.81]:60590 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030259AbWEYQkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:40:13 -0400
Date: Thu, 25 May 2006 09:42:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@pardus.org.tr>
Cc: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: Re: 2.6.17-rc5 : Lots of warning in MODPOST stage
Message-Id: <20060525094247.0cb9d267.rdunlap@xenotime.net>
In-Reply-To: <44756879.2010907@pardus.org.tr>
References: <44756879.2010907@pardus.org.tr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2006 11:19:05 +0300 İsmail Dönmez wrote:

> I am getting lots of warnings in MODPOST stage, not sure if this is known:
> 
> WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to
> .init.text: from .text between 'cleanup_module' (at offset 0x1e82) and
> 'ip2_loadmain'
> WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to
> .init.text: from .text between 'cleanup_module' (at offset 0x1ea8) and
> 'ip2_loadmain'
> WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to
> .init.text: from .text between 'ip2_loadmain' (at offset 0x2109) and
> 'set_irq'
> WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to
> .init.text: from .text between 'ip2_loadmain' (at offset 0x21e7) and
> 'set_irq'
> WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to
> .init.text: from .text between 'ip2_loadmain' (at offset 0x22a6) and
> 'set_irq'
> WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to
> .init.text: from .text between 'ip2_loadmain' (at offset 0x253d) and
> 'set_irq'
> WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to
> .init.text: from .text between 'ip2_loadmain' (at offset 0x25c1) and
> 'set_irq'

Hm, I don't see all of those.  However, Andrew has a patch for
(some of these) in -mm.  It fixes all of the warnings that I get.

[snip]

> WARNING: drivers/scsi/megaraid/megaraid_mbox.o - Section mismatch:
> reference to .init.text: from .text between 'megaraid_probe_one' (at
> offset 0x161) and 'megaraid_detach_one'
> WARNING: drivers/scsi/wd7000.o - Section mismatch: reference to
> .init.text: from .text between 'wd7000_detect' (at offset 0xa81) and
> 'wd7000_release'

Patches for these 2 will follow shortly (to linux-scsi m-l).

> WARNING: drivers/scsi/qla1280.o - Section mismatch: reference to
> .init.data: from .text between 'qla1280_get_token' (at offset 0x2a16)
> and 'qla1280_probe_one'
> WARNING: drivers/scsi/qla1280.o - Section mismatch: reference to
> .init.data: from .text between 'qla1280_get_token' (at offset 0x2a3c)
> and 'qla1280_probe_one'

Weird, I don't get this one either, and I used your .config file.
However, I'll put some eyes on it.

---
~Randy
