Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVD0NTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVD0NTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVD0NTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:19:25 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:33128 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261268AbVD0NTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:19:00 -0400
Date: Wed, 27 Apr 2005 15:18:58 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Froggy / Froggy Corp." <froggy@froggycorp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problem
Message-ID: <20050427131858.GC3918@harddisk-recovery.com>
References: <426BAFF2.54160A91@froggycorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426BAFF2.54160A91@froggycorp.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 04:40:50PM +0200, Froggy / Froggy Corp. wrote:
> I just see a memory problem : i have 1Gb install on my computer and only
> 275Mb are available when i take a look with "free".
> I use kernel 2.6.10, the bios tell me that i really have 1Gb (2*512
> DDR), the kernel have 4Gb option enable, so i dont understand.
> 
> If someone have an idea.
> 
> Thx in advance for any help,
> Regards,
> 
> Here is some information :

[snip]

> -------------------------------------------------------------------------
> Linux version 2.6.10 (root@Odyssee) (gcc version 3.3.5 (Debian
> 1:3.3.5-12)) #3 S
> MP Sun Apr 24 16:00:50 CEST 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
>  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000011340400 (usable)
>  BIOS-e820: 0000000011340400 - 0000000011343400 (ACPI NVS)
>  BIOS-e820: 0000000011343400 - 0000000011350400 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)

The kernel takes the amount of memory the BIOS tells it to use. If you
count all memory in the "usable" sections of the RAM map, it all adds
up to 275 MB.

  erik@arthur:~> bc -l
  ibase=16
  (((11340400 - 100000) + (9D800)) / 400 / 400
  274.8662109375

Might be a BIOS bug, or the BIOS RAM tester decided only 275 MB is
useable. Try upgrading the BIOS, or reset the CMOS.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
