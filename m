Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263224AbVCKHTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263224AbVCKHTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 02:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbVCKHTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 02:19:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:32730 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263224AbVCKHSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 02:18:40 -0500
Date: Thu, 10 Mar 2005 23:18:25 -0800
From: Greg KH <greg@kroah.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for 2.6.11)
Message-ID: <20050311071825.GA28613@kroah.com>
References: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 02:37:17PM +1100, Peter Chubb wrote:
> +/*
> + * The PCI subsystem is implemented as yet-another pseudo filesystem,
> + * albeit one that is never mounted.
> + * This is its magic number.
> + */
> +#define USR_PCI_MAGIC (0x12345678)

If you make it a real, mountable filesystem, then you don't need to have
any of your new syscalls, right?  Why not just do that instead?

thanks,

greg k-h
