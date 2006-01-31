Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWAaFZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWAaFZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 00:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWAaFZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 00:25:04 -0500
Received: from [205.233.219.253] ([205.233.219.253]:29403 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S965025AbWAaFZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 00:25:03 -0500
Date: Tue, 31 Jan 2006 00:21:01 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux1394-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee1394: allow building with absolute SUBDIRS path
Message-ID: <20060131052101.GC9667@conscoop.ottawa.on.ca>
References: <1138234743.10202.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138234743.10202.3.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 01:19:03AM +0100, Johannes Berg wrote:
> This patch allows building the modules with an absolute SUBDIRS path,
> especially for building them out of tree.

Applied, thanks.

Does anyone else feel like killing oui.c?

> Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>

Minor nit: This should be Signed-off-by:

I doubt anyone cares :)

Cheers,
Jody

> 
> --- a/drivers/ieee1394/Makefile
> +++ b/drivers/ieee1394/Makefile
> @@ -18,7 +19,7 @@ obj-$(CONFIG_IEEE1394_AMDTP) += amdtp.o
>  obj-$(CONFIG_IEEE1394_CMP) += cmp.o
>  
>  quiet_cmd_oui2c = OUI2C   $@
> -      cmd_oui2c = $(CONFIG_SHELL) $(srctree)/$(src)/oui2c.sh < $< > $@
> +      cmd_oui2c = $(CONFIG_SHELL) $(src)/oui2c.sh < $< > $@
>  
>  targets := oui.c
>  $(obj)/oui.o: $(obj)/oui.c
> 



-- 
