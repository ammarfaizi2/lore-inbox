Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932129AbWFDJtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWFDJtw (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWFDJtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:49:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751297AbWFDJtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:49:52 -0400
Date: Sun, 4 Jun 2006 02:49:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-Id: <20060604024937.0fb57258.akpm@osdl.org>
In-Reply-To: <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 02:38:03 -0700
"Barry K. Nathan" <barryn@pobox.com> wrote:

> When I build ACPI processor support as a module, I get this:
> 
>   MODPOST
> WARNING: drivers/acpi/processor.o - Section mismatch: reference to
> .init.data: from .text between 'acpi_processor_power_init' (at offset
> 0xfb0) and 'acpi_safe_halt'

yup.  The code in there is actually correct (assuming
acpi_processor_power_init()'s first invokation is at initcall-time).

Maybe we'll do something to kill the warning, once we're down to the last
few thousand of them ;)


> (This is also true of -mm2, but I didn't get a chance to report it
> before -mm3 was released. Before then, I built it into the kernel and
> not as a module.)
> 
> and I still get this:
> WARNING: "scsi_tgt_queue_command" [drivers/scsi/libsrp.ko] undefined!

git-scsi-target Kconfig snafu.  I passed it over to James the other day. 
He might have fixed it - I get my git-scsi-misc via git-infiniband (don't
ask) and it's a bit laggy.


