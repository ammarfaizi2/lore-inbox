Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVCGRBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVCGRBV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVCGRBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:01:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:394 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261889AbVCGRBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:01:17 -0500
Message-ID: <422C88CD.7000009@pobox.com>
Date: Mon, 07 Mar 2005 12:01:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Fibre attached pcnet/32
References: <1110198605.28860.32.camel@localhost.localdomain>
In-Reply-To: <1110198605.28860.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The current driver does workarounds for errata that do not work with
> fibre attached devices. This patch avoids doing the workaround on the
> only known fibre attach pcnet/32 hardware. All handling is automated on
> pci sub-ids
> 
> Patch by: Guido Guenther
> Signed-off-by: Alan Cox <alan@redhat.com>


Linus already has this:

ChangeSet@1.1966.107.1, 2005-01-27 15:55:00-05:00, brazilnut@us.ibm.com
   [PATCH] pcnet32: 79c976 with fiber optic fix

   After testing this patch I agree that it should be applied.  The one
   change I made was to print the device name (ethN) instead of 'pcnet32'.
   Tested ia32.

   From: Guido Guenther <agx@sigxcpu.org>,
         Lars Munch <lars@segv.dk>

   Skip PHY selection on Allied Telesyn 2701FX, it looses the link 
otherwise.
   Fix up the AT 2700FX as well.

   Signed-Off-By: Guido Guenther <agx@sigxcpu.org>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   signed-off-by: Don Fry <brazilnut@us.ibm.com>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

