Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVICE6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVICE6x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 00:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVICE6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 00:58:53 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:33433 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751010AbVICE6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 00:58:51 -0400
Message-ID: <43192D89.50504@bigpond.net.au>
Date: Sat, 03 Sep 2005 14:58:49 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.13-mm1: hangs during boot ...
References: <F7DC2337C7631D4386A2DF6E8FB22B30047FA061@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30047FA061@hdsmsx401.amr.corp.intel.com>
Content-Type: multipart/mixed;
 boundary="------------080805060704010008080101"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 3 Sep 2005 04:58:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080805060704010008080101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Brown, Len wrote:
>>>[  279.662960]  [<c02d5c74>] wait_for_completion+0xa4/0x110
> 
> 
> possibly a missing interrupt?
> 
> 
>>CONFIG_ACPI=y
> 
> 
> any difference if booted with "acpi=off" or "acpi=noirq"?

Yes.  In both cases, the system appears to boot normally but I'm unable 
to login or connect via ssh.  Also there's a "device not ready" message 
after the scsi initialization which I don't normally see.  I've attached 
the scsi initialization output.  The PF_NETLINK error messages after the 
login prompt in this output are created whenever I try to log in or 
connect via ssh.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------080805060704010008080101
Content-Type: text/plain;
 name="acpi=off.output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi=off.output"

[    8.345086] SCSI subsystem initialized
[    8.427503] sym0: <810a> rev 0x23 at pci 0000:00:08.0 irq 16
[    8.504636] sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
[    8.588216] sym0: SCSI BUS has been reset.
[    8.642194] scsi0 : sym-2.2.1
[   12.368622]   Vendor: PIONEER   Model: DVD-ROM DVD-303R  Rev: 2.00
[   12.450118]   Type:   CD-ROM                             ANSI SCSI revision:2[   12.546506]  target0:0:2: Beginning Domain Validation
[   12.613354]  target0:0:2: asynchronous.
[   12.667699]  target0:0:2: Domain Validation skipping write tests
[   12.747629]  target0:0:2: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 8)
[   12.837395]  target0:0:2: Ending Domain Validation
[   13.256875]   Vendor: SONY      Model: CD-RW  CRX140S    Rev: 1.0e
[   13.338323]   Type:   CD-ROM                             ANSI SCSI revision:4[   13.434891]  target0:0:4: Beginning Domain Validation
[   13.503101]  target0:0:4: asynchronous.
[   13.602931]  target0:0:4: Domain Validation skipping write tests
[   13.683605]  target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 8)
[   13.777934]  target0:0:4: Ending Domain Validation
[   14.884703] Device  not ready.
[   15.763312] kjournald starting.  Commit interval 5 seconds
[   15.835612] EXT3-fs: mounted filesystem with ordered data mode.


Fedora Core release 4 (Stentz)
Kernel 2.6.13-mm1 on an i686

origma.pw.nest login:

[  101.886572] DEBUG: Failed to load PF_NETLINK protocol 9
[  101.963572] DEBUG: Failed to load PF_NETLINK protocol 9


--------------080805060704010008080101--
