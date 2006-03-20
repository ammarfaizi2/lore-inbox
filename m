Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWCTTyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWCTTyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWCTTyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:54:37 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:2267 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S964961AbWCTTyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:54:33 -0500
Date: Mon, 20 Mar 2006 11:54:15 -0800
From: Greg KH <gregkh@suse.de>
To: Mark Maule <maule@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       j-nomura@ce.jp.nec.com
Subject: Re: [PATCH 2.6.16-rc6-mm1] fix ia64 MSI build problems
Message-ID: <20060320195415.GA17263@suse.de>
References: <20060320193638.GH31238@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320193638.GH31238@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 01:36:38PM -0600, Mark Maule wrote:
> Fix MSI-related build problems on ia64.
> 
> Move arch/ia64/sn/pci/msi.c to drivers/pci/msi-altix.c
> Move struct msi_ops in drivers/pci/msi.h to the top of the file so asm/msi.h
>     can make use of the declaration.
> Clean up msi platform defintions in machvec.h (thanks to j-nomura@ce.jp.nec.com
>     for the patch to do that).
> 
> Signed-off-by: Mark Maule <maule@sgi.com>

Does this replace any of your pre-existing msi patches in my tree (and
in -mm)?  Shouldn't you just merge a few of them together now so that if
someone were to apply stuff in order, the build is not broken for any
step along the patch trail?

And also, the Makefile should be changed as Matthew pointed out.

So, care to redo this?

thanks,

greg k-h
