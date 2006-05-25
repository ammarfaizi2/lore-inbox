Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbWEYKly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWEYKly (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWEYKly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:41:54 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:5804 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965116AbWEYKlx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:41:53 -0400
Date: Thu, 25 May 2006 11:41:47 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 3/3] pci: gt96100eth use pci probing
Message-ID: <20060525104147.GB3822@linux-mips.org>
References: <20060525003151.598EAC7C19@atrey.karlin.mff.cuni.cz> <4474FFE1.4030202@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4474FFE1.4030202@garzik.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 08:52:49PM -0400, Jeff Garzik wrote:

> Jiri Slaby wrote:
> >gt96100eth use pci probing
> >
> >Convert pci_find_device to pci probing. Use dev_* macros for printing.
> >
> >Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

The GT-96100 is not a PCI device but a system controller.  The driver
just checkes for the PCI ID to ensure it is not by accident being loaded
on the wrong type of system.  Which of course is suspect.  If anything it
should become a platform device.

  Ralf
