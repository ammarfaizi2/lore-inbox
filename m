Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272915AbRIHAAm>; Fri, 7 Sep 2001 20:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272921AbRIHAAc>; Fri, 7 Sep 2001 20:00:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31243 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272915AbRIHAAN>; Fri, 7 Sep 2001 20:00:13 -0400
Subject: Re: dynamic arrival of scsi hosts...
To: ashok.raj@intel.com (Raj, Ashok)
Date: Sat, 8 Sep 2001 01:04:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ("Linux-Kernel (E-mail)")
In-Reply-To: <8A9A5F4E6576D511B98F00508B68C20A0BC9A2@orsmsx106.jf.intel.com> from "Raj, Ashok" at Sep 07, 2001 04:55:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fVbw-0002uv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> does the current linux 2.4.x series handle new controller additions.? I have
> seen the new pci hotplug
> interfaces, but iam not sure if the scsi midlayer can handle new controllers
> showing up.?

It can.

> for eg: if during scsi_register_host() i have just one controller. If i add
> another one after system is up, will this 
> framework be able to handle this new controller in the mix? if there is a
> mechanism to do this
> what should the low level hba driver writer do to make this happen.?

Exactly as you are doing now. If you think about this its the same as
doing "insmod" of a scsi driver for an existing card. The pci hotplug events
occur in process context so you should have no problem

Alan
