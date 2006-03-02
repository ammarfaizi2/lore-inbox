Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWCBQr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWCBQr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCBQr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:47:29 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:8429 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750782AbWCBQr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:47:29 -0500
Date: Thu, 2 Mar 2006 08:47:20 -0800
From: Greg KH <greg@kroah.com>
To: Ren? Rebe <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.org>
Subject: Re: MAX_USBFS_BUFFER_SIZE
Message-ID: <20060302164720.GA31076@kroah.com>
References: <200603012116.25869.rene@exactcode.de> <200603012242.35633.rene@exactcode.de> <20060301215423.GA17825@kroah.com> <200603021703.26549.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603021703.26549.rene@exactcode.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 05:03:26PM +0100, Ren? Rebe wrote:
> Hi,
> 
> On Wednesday 01 March 2006 22:54, Greg KH wrote:
> 
> > > > Why not just send down 2 urbs with that size then, that would keep the
> > > > pipe quite full.
> > > 
> > > Because that requires even more modifications to libusb and sane (i_usb) ...
> > 
> > No, do it in your application I mean.
> 
> Ok, tweaking libusb to queue N URBs for reads to be split (resulting in 9 URBs
> in my usecase) I see a nearly 100% improvement here (2 times faster).
> 
> How many URBs may I queue? Nearly infinite (in my case that would be max 64)
> or is there some tiny static list somewhere in the affected code-path?

There is no static list that I know of, as it is all just pointers.
Just don't DOS the kernel by sending it an infinate ammount of memory :)

More details can be found on the linux-usb-devel list if you ask there.

thanks,

greg k-h
