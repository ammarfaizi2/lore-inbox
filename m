Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSFYOtV>; Tue, 25 Jun 2002 10:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315517AbSFYOtV>; Tue, 25 Jun 2002 10:49:21 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:52962 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S315513AbSFYOtU>; Tue, 25 Jun 2002 10:49:20 -0400
Date: Tue, 25 Jun 2002 16:49:18 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question concerning PCI device driver
Message-ID: <20020625144918.GA22794@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	"Bloch, Jack" <Jack.Bloch@icn.siemens.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <180577A42806D61189D30008C7E632E8793954@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180577A42806D61189D30008C7E632E8793954@boca213a.boca.ssc.siemens.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2002 at 09:21:46AM -0400, Bloch, Jack wrote:

> I am now porting this driver to a 2.4 Kernel and in the Linux device driver
> book it talks about using pci_module_init. How do I get the major number to
> allow for IOCTL commands? 

Just do it in the same way, only the pci management functions changed:
you will now need to register your chrdev in the pci_probe callback
instead of the module_init() function.

You should look at the existing drivers in the kernel tree, under
drivers/char, and you'll find many drivers which work that way...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
