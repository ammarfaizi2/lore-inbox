Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265077AbUFRJZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265077AbUFRJZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbUFRJZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:25:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6919 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265090AbUFRJV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:21:26 -0400
Date: Fri, 18 Jun 2004 10:21:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
Message-ID: <20040618102120.A29213@flint.arm.linux.org.uk>
Mail-Followup-To: Krzysztof Halasa <khc@pm.waw.pl>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <1087481331.2210.27.camel@mulgrave> <m33c4tsnex.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m33c4tsnex.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Fri, Jun 18, 2004 at 02:46:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 02:46:46AM +0200, Krzysztof Halasa wrote:
> If we fix the API we should IMHO also remove set_dma_mask() and add
> the number of address bits to the arguments of actual mapping
> functions.

Good idea, except for the fact that we have drivers merged which have
real masks like 0x0fefffff.  It _really is_ a mask and not a number
of bits.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
