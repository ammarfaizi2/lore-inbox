Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbVA2Ebd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbVA2Ebd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 23:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbVA2Ebd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 23:31:33 -0500
Received: from trantor.org.uk ([213.146.130.142]:58348 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S262849AbVA2Eba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 23:31:30 -0500
Subject: Re: compat ioctl for submiting URB
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Christopher Li <chrisl@vmware.com>
Cc: linux kernel mail list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050128212304.GA11024@64m.dyndns.org>
References: <20050128212304.GA11024@64m.dyndns.org>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 04:29:51 +0000
Message-Id: <1106972991.3972.57.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 16:23 -0500, Christopher Li wrote:
> +#ifdef CONFIG_IA32_EMULATION
> +
> +       case USBDEVFS_SUBMITURB32:
> +               snoop(&dev->dev, "%s: SUBMITURB32\n", __FUNCTION__);
> +               ret = proc_submiturb_compat(ps, p);
> +               if (ret >= 0)
> +                       inode->i_mtime = CURRENT_TIME;
> +               break;
> +#endif

Why don't other 64bit architectures need this chunk?

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import

