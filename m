Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275304AbTHGMvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275305AbTHGMvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:51:25 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:65042 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S275304AbTHGMvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:51:24 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.0-test2: Lost USB mouse after resuming from S3
Date: Thu, 7 Aug 2003 20:51:00 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, usb-devel@lists.sourceforge.net
References: <200308070037.31630.mflt1@micrologica.com.hk> <20030806213941.GA7618@kroah.com>
In-Reply-To: <20030806213941.GA7618@kroah.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308072051.00679.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 August 2003 05:39, Greg KH wrote:
> On Thu, Aug 07, 2003 at 12:37:31AM +0800, Michael Frank wrote:
> > Causes are that usb-host controller does no handle S3 yet _plus_
> > possibly (depending on your hardware) loss of PCI interrupt links as
> > current ACPI does not resume those.
>
> Known issue, please unload the usb modules before suspending them.
>
> The upcoming suspend patches will allow us to fix this "properly",
> please give us a few weeks :)
>

And mind the _plus_ issue - On my hardware you could debug dead interrupts 
in the host controller code forever...

Have posted a patch to fix ACPI, but no feedback as of yet ;)

Regards
Michael

-- 
Powered by linux-2.6-test2-mm4. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/

