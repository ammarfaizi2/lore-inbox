Return-Path: <linux-kernel-owner+w=401wt.eu-S1759119AbWLINHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759119AbWLINHT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759123AbWLINHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:07:19 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39250 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759119AbWLINHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:07:17 -0500
Date: Sat, 9 Dec 2006 13:14:48 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI legacy resource fix
Message-ID: <20061209131448.4c878b64@localhost.localdomain>
In-Reply-To: <1165651931.7443.377.camel@gullible>
References: <20061206134143.GA6772@linux-mips.org>
	<1165625178.7443.334.camel@gullible>
	<20061209012552.GA15216@linux-mips.org>
	<1165630410.7443.346.camel@gullible>
	<20061209024627.6bb11a58@localhost.localdomain>
	<1165651931.7443.377.camel@gullible>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Dec 2006 03:12:11 -0500
Ben Collins <ben.collins@ubuntu.com> wrote:
> My controller is in legacy mode, however, it never gets to here because
> of this call, just before this block of code:
> 
>         rc = pci_request_regions(pdev, DRV_NAME);
>         if (rc) {
>                 disable_dev_on_err = 0;
>                 goto err_out;
>         }

Then you don't have the fix applied that was posted. That code is not
present in the form you pasted in the fixed version of the libata code.
It is within an if (!legacy_mode)

Alan
