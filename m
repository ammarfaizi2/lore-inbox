Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbUL1U5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUL1U5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 15:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbUL1U5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 15:57:48 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:63888 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261245AbUL1U5r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 15:57:47 -0500
Date: Tue, 28 Dec 2004 21:55:53 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: 2.6.10 - Incorrect return from PCI ide controller
Message-ID: <20041228205553.GA18525@electric-eye.fr.zoreil.com>
References: <1104158258.20952.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104158258.20952.44.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> :
> Several IDE drivers return positive values as errors in the PCI setup
> code. Unfortunately the PCI layer considers positive values as success
> so the driver skips the device but still claims it and things then go
> downhill.
> 
> This fixes the IT8172 driver. There are other drivers with this bug (eg
> generic) but the -ac IDE is sufficiently diverged from base that someone
> else needs to generate/test the more divergent cases.

ide_setup_pci_device{s} will always claim that everything is fine even
though do_ide_setup_pci_device() has some opportunity to fail.

Should it matter as well ?

--
Ueimor
