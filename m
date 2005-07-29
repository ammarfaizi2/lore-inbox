Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVG2APV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVG2APV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVG2APU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:15:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26783 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262171AbVG2AOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:14:07 -0400
Date: Fri, 29 Jul 2005 10:13:50 +1000
From: Nathan Scott <nathans@sgi.com>
To: Mark Bellon <mbellon@mvista.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH]  disk quotas fail when /etc/mtab is symlinked to /proc/mounts
Message-ID: <20050729101350.G3437507@wobbly.melbourne.sgi.com>
References: <42E97236.6080404@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <42E97236.6080404@mvista.com>; from mbellon@mvista.com on Thu, Jul 28, 2005 at 05:03:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 05:03:02PM -0700, Mark Bellon wrote:
> The attached patchs modify the EXT[2|3] and [X|J]FS codes to add the 

The XFS component is incorrect, we're already doing this elsewhere
(over in fs/xfs/quota/xfs_qm_bhv.c), so please drop this last part
from your patch...

> diff -Naur linux-2.6.13-rc3-git9-orig/fs/xfs/xfs_vfsops.c linux-2.6.13-rc3-git9/fs/xfs/xfs_vfsops.c
> ...
> +		{ XFS_UQUOTA_ACTIVE,		"," "usrquota" },
> +		{ XFS_GQUOTA_ACTIVE,		"," "grpquota" },

thanks.

-- 
Nathan
