Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWFMRd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWFMRd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFMRd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:33:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:40748 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750776AbWFMRd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:33:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I03bZHUAFUfHjYjqMv8uYyNVf4sIZf56Zq9kJniveJl4ygziPT36/n0CHHR6jcrrbEkgx0GfzCvWB6CJq7LU+W/IWT3ho8ANX04V2UEwFMELcCEGJShF95VhplNjWbvX6T4AmUnTCs6IEHgYGwaQPEh6mgPfLwoqkLVIg4wQAHM=
Message-ID: <b1bc6a000606131033u4707200fm1b78885c0ee55770@mail.gmail.com>
Date: Tue, 13 Jun 2006 10:33:54 -0700
From: "adam radford" <aradford@gmail.com>
To: gbakos@cfa.harvard.edu
Subject: Re: 2.6.16-20, sdc sector size 0 reported
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.58.0606131230350.28216@titan.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.SOL.4.58.0606131230350.28216@titan.cfa.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gbakos,

The driver version you are running is not compatible with that kernel.
Please re-test with the in-kernel 3w-9xxx driver.

-Adam

On 6/13/06, Gaspar Bakos <gbakos@cfa.harvard.edu> wrote:
> Hi,
>
> A dual AMD opteron processor machine works fine with 2.6.12-3 kernel and 3ware
> drivers (2.26.03.015fw - release.).
> Updating the kernel to 2.6.16.20, retaining the same 3ware driver and having
> virtually the same kernel config as in 2.6.12-3 leads to the following
> messages at boot:
>
> Jun 13 12:12:47 dummy kernel: scsi4 : 3ware 9000 Storage Controller
> Jun 13 12:12:47 dummy kernel: 3w-9xxx: scsi4: Found a 3ware 9000 Storage Controller at 0xfc6df800, IRQ: 185.
> Jun 13 12:12:47 dummy kernel:  sdb10 > sdb4
> Jun 13 12:12:47 dummy kernel: sd 1:0:0:0: Attached scsi disk sdb
> Jun 13 12:12:47 dummy kernel: XFS mounting filesystem md1
> Jun 13 12:12:47 dummy kernel: 3w-9xxx: scsi4: Firmware FE9X 2.06.00.009, BIOS BE9X 2.03.01.051, Ports: 8.
> Jun 13 12:12:47 dummy kernel:   Vendor:           Model:                   Rev:
> Jun 13 12:12:47 dummy kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
> Jun 13 12:12:47 dummy kernel: sdc : sector size 0 reported, assuming 512.
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Any idea wdummy this could mean?
>
> Config is at: http://www.cfa.harvard.edu/~gbakos/5tahfc/
>
> Jun 13 12:12:47 dummy kernel: SCSI device sdc: 1 512-byte hdwr sectors (0 MB)
> Jun 13 12:12:47 dummy kernel: sdc: Write Protect is off
> Jun 13 12:12:47 dummy kernel: sdc: asking for cache data failed
> Jun 13 12:12:47 dummy kernel: sdc: assuming drive cache: write through
> Jun 13 12:12:47 dummy kernel: sdc : sector size 0 reported, assuming 512.
> Jun 13 12:12:47 dummy kernel: SCSI device sdc: 1 512-byte hdwr sectors (0 MB)
> Jun 13 12:12:47 dummy kernel: sdc: Write Protect is off
> Jun 13 12:12:47 dummy kernel: sdc: asking for cache data failed
> Jun 13 12:12:47 dummy kernel: sdc: assuming drive cache: write through
> Jun 13 12:12:47 dummy kernel:  sdc: unknown partition table
>
> Cheers
> Gaspar
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
