Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUFQUXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUFQUXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUFQUXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:23:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:183 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262422AbUFQUX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:23:28 -0400
Date: Thu, 17 Jun 2004 12:58:51 -0700
From: Greg KH <greg@kroah.com>
To: kai.engert@gmx.de
Cc: linux-kernel@vger.kernel.org, "Nemosoft Unv." <webcam@smcc.demon.nl>
Subject: Re: small patch: enable pwc usb camera driver
Message-ID: <20040617195851.GA23533@kroah.com>
References: <40C466FB.1040309@kuix.de> <20040607202036.GA6185@kroah.com> <200406080027.04577@smcc.demon.nl> <20040607223919.GA9172@kroah.com> <40D1909F.4090408@kuix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D1909F.4090408@kuix.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 02:37:51PM +0200, Kai Engert wrote:
> Greg KH wrote:
> >On Tue, Jun 08, 2004 at 12:27:04AM +0200, Nemosoft Unv. wrote:
> >>... 
> >>Don't use this. It will BUG() your kernel hard, because of a double 
> >>free(). 
> 
> I confirm, if you disconnect the device / unload the driver, it doesn't 
> take long and the kernel reports an exception. My fault, sorry.
> 
> >... I'll wait for someone to send another patch fixing this one ...
> 
> I'm attaching a new patch:
> 
> - revert video device release code to original no-op,
>   using correct function signature.

Ick ick ick!  No, that's not the way to fix this.

Bah, time to mark the driver broken again...

greg k-h
