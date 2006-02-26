Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWBZXzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWBZXzv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWBZXzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:55:51 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:60099 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751438AbWBZXzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:55:51 -0500
Date: Sun, 26 Feb 2006 16:55:49 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, scottm@somanetworks.com,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [2.6 patch] drivers/pci/hotplug/cpqphp_ctrl.c: board_replaced(): remove dead code
Message-ID: <20060226235549.GW28587@parisc-linux.org>
References: <20060226211651.GN3674@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226211651.GN3674@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 10:16:51PM +0100, Adrian Bunk wrote:
> he Coverity checker correctly noted, that in function board_replaced in
> drivers/pci/hotplug/cpqphp_ctrl.c, the variable src always has the
> value 8, and therefore much code after the
> 
> ...
>                         if (rc || src) {
> ...
>                                 if (rc)
>                                         return rc;
>                                 else
>                                         return 1;
>                         }
> ...
> 
> 
> can never be called.
> 
> This patch removes the unreachable code in this function fixing kernel 
> Bugzilla #6073.

It seems much  more  likely to me that the '|| src' indicates a bug, and
the unreachable  code  should have been  reached.  Why not cc the
maintainer for his opinion?
