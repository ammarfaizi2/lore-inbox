Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVAGSSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVAGSSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVAGSRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:17:08 -0500
Received: from dialin-145-254-060-130.arcor-ip.net ([145.254.60.130]:50184
	"EHLO spit.home") by vger.kernel.org with ESMTP id S261424AbVAGSP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:15:56 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] fs/hfsplus/: misc cleanups
Date: Fri, 7 Jan 2005 16:23:46 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050107012615.GB14108@stusta.de>
In-Reply-To: <20050107012615.GB14108@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501071623.48201.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 07 January 2005 02:26, Adrian Bunk wrote:

> +#define hfs_bnode_split hfsplus_bnode_split
> +static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd);
> +
> +#define hfs_brec_update_parent hfsplus_brec_update_parent
> +static int hfs_brec_update_parent(struct hfs_find_data *fd);
> +
> +#define hfs_btree_inc_height hfsplus_btree_inc_height
> +static int hfs_btree_inc_height(struct hfs_btree *);

If these functions become static, the defines are not needed anymore. This 
code is "shared" with hfs and only kernel wide visible functions are renamed 
this way.

bye, Roman
