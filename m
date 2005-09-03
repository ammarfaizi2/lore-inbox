Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVICRbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVICRbE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 13:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVICRbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 13:31:03 -0400
Received: from [81.2.110.250] ([81.2.110.250]:16586 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751122AbVICRbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 13:31:01 -0400
Subject: Re: Hotswap support for libata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: lkosewsk@gmail.com, Ravi Wijayaratne <ravi_wija@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <431944C8.5070205@pobox.com>
References: <20050902224418.78897.qmail@web32512.mail.mud.yahoo.com>
	 <355e5e5e05090223231726b94a@mail.gmail.com>
	 <355e5e5e05090223259e47cf6@mail.gmail.com>  <431944C8.5070205@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Sep 2005 18:53:11 +0100
Message-Id: <1125769991.14987.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-09-03 at 02:38 -0400, Jeff Garzik wrote:
> controllers myself.  Many controllers don't have an explicit hotplug 
> interrupt, but rather we must examine the PhyRdy bit in the standard 
> SError register for details.  If the bit's state changes in any way 
> (including two or more state changes), we (a) check for device presence, 
> and (b) if device is present, initialize it (SET FEATURES - XFER MODE, 
> etc.).

For PATA we may need to reprogram both drives so please be sure that is
allowed for. Also much PATA is "warm swap" not "hot swap" as we have to
perform actions in software prior to the swap.

Alan

