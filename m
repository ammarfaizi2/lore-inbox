Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbUKGP2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUKGP2P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 10:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUKGP2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 10:28:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62981 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261626AbUKGP2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 10:28:08 -0500
Date: Sun, 7 Nov 2004 15:28:05 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
Message-ID: <20041107152805.B4009@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <1099346276148@kroah.com> <10993462773570@kroah.com> <20041102223229.A10969@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041102223229.A10969@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Nov 02, 2004 at 10:32:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 10:32:29PM +0000, Russell King wrote:
> On Mon, Nov 01, 2004 at 01:57:57PM -0800, Greg KH wrote:
> > This patch fixes the problem by using a separate semaphore, called
> > dpm_list_sem, to cover the places where we need the device pm lists to be
> > stable, and by being careful about how we traverse the lists on suspend and
> > resume.  I have analysed the various cases that can occur and I am
> > confident that I have handled them all correctly.  I posted this patch
> > together with a detailed analysis 10 days ago.
> 
> Does this mean that a device driver can have its suspend or resume
> methods called in the middle of a probe or remove on a different CPU ?
> (note: x86 APM does not freeze all processes last time I checked...)
> 
> If yes, has anyone audited the drivers to ensure that they're correct
> in respect of this?

I'll repost the above question since it's of fundamental importance.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
