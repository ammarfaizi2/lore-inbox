Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbUKJBjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUKJBjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUKJBjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:39:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:55708 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261827AbUKJBir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:38:47 -0500
Date: Tue, 9 Nov 2004 17:37:01 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, paulus@au.ibm.com
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
Message-ID: <20041110013700.GF9496@kroah.com>
References: <1099346276148@kroah.com> <10993462773570@kroah.com> <20041102223229.A10969@flint.arm.linux.org.uk> <20041107152805.B4009@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107152805.B4009@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 03:28:05PM +0000, Russell King wrote:
> On Tue, Nov 02, 2004 at 10:32:29PM +0000, Russell King wrote:
> > On Mon, Nov 01, 2004 at 01:57:57PM -0800, Greg KH wrote:
> > > This patch fixes the problem by using a separate semaphore, called
> > > dpm_list_sem, to cover the places where we need the device pm lists to be
> > > stable, and by being careful about how we traverse the lists on suspend and
> > > resume.  I have analysed the various cases that can occur and I am
> > > confident that I have handled them all correctly.  I posted this patch
> > > together with a detailed analysis 10 days ago.
> > 
> > Does this mean that a device driver can have its suspend or resume
> > methods called in the middle of a probe or remove on a different CPU ?
> > (note: x86 APM does not freeze all processes last time I checked...)
> > 
> > If yes, has anyone audited the drivers to ensure that they're correct
> > in respect of this?
> 
> I'll repost the above question since it's of fundamental importance.

Paul sent in this change, so I'll let him address this.

thanks,

greg k-h
