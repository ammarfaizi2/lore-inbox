Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVCRNQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVCRNQT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 08:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVCRNQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 08:16:19 -0500
Received: from [81.2.110.250] ([81.2.110.250]:38332 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261594AbVCRNQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 08:16:16 -0500
Subject: Re: Need break driver<-->pci-device automatic association
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain>
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111151648.9874.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 18 Mar 2005 13:14:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-18 at 08:57, Jacques Goldberg wrote:
>  Question: is there a way, as of kernels 2.6.10 and above, to release the
> device from the serial driver, without having to recompile the kernel?

There is an ugly way (fake a hot unplug 8)) but if you want to do it
properly you need to get the relevant pci check into the serial driver
proper by submitting it to Russell King. That way the serial driver can
skip the PCI devices that turn out to be modems

