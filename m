Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVCOPGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVCOPGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVCOPGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:06:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:528 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261316AbVCOPGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:06:44 -0500
Date: Tue, 15 Mar 2005 16:06:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: 2.6.11-mm3: megaraid_sas.c: stack usage
Message-ID: <20050315150641.GO3189@stusta.de>
References: <20050312034222.12a264c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 03:42:22AM -0800, Andrew Morton wrote:
>...
> All 606 patches:
>...
> megaraid_sas-announcing-new-module-for.patch
>   megaraid_sas: Announcing new module for LSI Logic's SAS based MegaRAID controllers
>...

Enormous stack usage:
- megasas_init_mfi (due to ctrl_info)

Big stack usage:
- megasas_mgmt_ioctl (due to uioc and dv)
- megasas_mgmt_fw_ioctl (due to uioc)

Please fix this.
 
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

