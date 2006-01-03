Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWACObm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWACObm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWACObm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:31:42 -0500
Received: from p5488871F.dip0.t-ipconnect.de ([84.136.135.31]:15529 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S1751433AbWACObl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:31:41 -0500
Date: Tue, 3 Jan 2006 14:28:26 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: unable to mount root device in 2.6.14.5 (was: Re: [PATCH] PCI patches for 2.6.10)
Message-ID: <20060103142826.GA9696@ds20.borg.net>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>,
	"Maciej W. Rozycki" <macro@mips.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20060102182018.GA25971@ds20.borg.net> <Pine.LNX.4.61.0601031214160.21127@perivale.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601031214160.21127@perivale.mips.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 12:21:34PM +0000, Maciej W. Rozycki wrote:
> On Mon, 2 Jan 2006, Thorsten Kranzkowski wrote:
> > I tracked this down to this patch (to be precise, the PCI_CLASS_NOT_DEFINED 
> > part of it). Removing the 'class == PCI_CLASS_NOT_DEFINED ||' clause makes
> > it boot again.
> 
>  You need to add a quirk for the device to initialize its class to be a 
> SCSI controller.

Today I went to learn how to implement pci quirks,
only to discover that the newly released 2.6.15 introduces the correct fix 
for my scsi-chip in pci/quirks.c ... :)
 
Thanks anyway, 
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
