Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751707AbWGAUdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbWGAUdA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 16:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWGAUc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 16:32:59 -0400
Received: from mail.charite.de ([160.45.207.131]:15832 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751539AbWGAUc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 16:32:58 -0400
Date: Sat, 1 Jul 2006 22:32:56 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: 2.6.17-mm5 -  ACPI Exception (acpi_processor-0272): AE_BAD_PARAMETER, Invalid _PSS data [20060623]
Message-ID: <20060701203256.GD13558@charite.de>
Mail-Followup-To: "Brown, Len" <len.brown@intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6E58B72@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6E58B72@hdsmsx411.amr.corp.intel.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Brown, Len <len.brown@intel.com>:
> 1. message was always there, but was disabled before.
> 
> 	Please build a previous kernel that doesn't show
> 	this message (say 2.6.17) with CONFIG_ACPI_DEBUG=y
> 	and report if you see the same message.
> 
> 	Note that the patch that enabled these messages
> 	had been in mm before for several months
> 	and just dropped out for a bit before -mm4,
> 	so you might see this in earlier -mm's too.

2.6.17.3:

Jul  1 22:23:40 knarzkiste kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.2)
Jul  1 22:23:40 knarzkiste kernel: acpi_utils-0066 [04] extract_package       : Invalid 'package' argument
Jul  1 22:23:40 knarzkiste kernel: acpi_processor-0277 [03] processor_get_performa: Invalid _PSS data
Jul  1 22:23:40 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
Jul  1 22:23:40 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
Jul  1 22:23:40 knarzkiste kernel: cpu_init done, current fid 0x8, vid 0x2
Jul  1 22:23:40 knarzkiste kernel: powernow-k8: ph2 null fid transition 0x8

So you were right.

> 2. Some other regression
> 
> 	Lets hope not.
> 
> In any case, it would be good to get to the root cause.
> Please open a bugzilla here:
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> and attach the output from acpidump found in the
> latest pmtools here:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Done
 
> After the above, you might also check for an updated BIOS.

Updates are a bit hard, without windows :(

-- 
_________________________________________________

  Charité - Universitätsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. Geschäftsbereich Informationsmanagement
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 450 570962
   Ralf.Hildebrandt@charite.de
   http://www.charite.de
