Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUHKQYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUHKQYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268098AbUHKQYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:24:21 -0400
Received: from the-village.bc.nu ([81.2.110.252]:54993 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268108AbUHKQXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:23:49 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Nathan Bryant <nbryant@optonline.net>, Pavel Machek <pavel@ucw.cz>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1092231462.2087.3.camel@mulgrave>
References: <4119611D.60401@optonline.net>
	 <20040811080935.GA26098@elf.ucw.cz>  <411A1B72.1010302@optonline.net>
	 <1092231462.2087.3.camel@mulgrave>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092237664.19009.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 11 Aug 2004 16:21:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-11 at 14:37, James Bottomley wrote:
> Actually, the answer is to most intents and purposes "yes".  You are
> technically correct: there's no way to disable DMA in SCSI.  However,
> once a device is quiesced, it has no outstanding commands, so there will
> be no outstanding DMA to that device. 

In addition we are not doing SCSI target so multi-initiator is ok.
One question James - what are the rules for power management with
SCSI when we provide termpwr to a shared bus ?

