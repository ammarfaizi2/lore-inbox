Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270673AbTHJVcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270677AbTHJVcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:32:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:5009 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270673AbTHJVcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:32:23 -0400
Date: Sun, 10 Aug 2003 14:32:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Weber <shawk@gmx.net>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       akpm@digeo.com, adq_dvb@lidskialf.net
Subject: Re: [BUG mm-tree of test2/test3] nforce2-acpi-fixes breaks via ide
 controller
Message-Id: <20030810143220.0a4d1e69.akpm@osdl.org>
In-Reply-To: <1060533632.3886.19.camel@athxp.bwlinux.de>
References: <1060533632.3886.19.camel@athxp.bwlinux.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Weber <shawk@gmx.net> wrote:
>
> Hi all
> 
> Since the test2-mm1 sources I get the following error during boot:
> 
> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> VP_IDE: (ide_setup_pci_device:) Could not enable device.
> 
> This results in not being able to use DMA for any devices connected to
> my IDE controller. Hdparm says permission denied when I do a hdparm -d1
> /dev/hda e.g.
> 
> I checked with a vanilla kernel and everything is working fine there.
> Going through the broken-out patches from Andrew Morton I found the one
> patch that caused the above behavior: nforce2-acpi-fixes.patch

Thanks for working that out.  It must have taken some time.

> I do not know why it should interfere with my via stuff, but it does. A
> vanilla test3 kernel is working fine as well, whereas test3-mm1 shows
> the same error as before with test2-mmX.

Me either.  Unfortunately that patch does five different things so we
cannot easily narrow it down further.


