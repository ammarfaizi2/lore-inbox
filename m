Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbWCVUPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWCVUPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbWCVUPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:15:00 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:8392 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932616AbWCVUO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:14:58 -0500
Date: Wed, 22 Mar 2006 14:14:32 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector
Message-ID: <20060322201432.GA17653@sergelap.austin.ibm.com>
References: <44216612.3060406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44216612.3060406@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yi Yang (yang.y.yi@gmail.com):
> +#ifdef __KERNEL__
> +#ifdef CONFIG_FS_EVENTS
> +extern void raise_fsevent(struct dentry * dentryp, u32 mask);
> +extern void raise_fsevent_move(struct inode * olddir, const char * oldname, 
> +		struct inode * newdir, const char * newname, u32 mask);
> +extern void raise_fsevent_create(struct inode * inode, 
> +		const char * name, u32 mask);
> +#else
> +static void raise_fsevent(struct dentry * dentryp,  u32 mask);
> +{}

Hmm, this compiles, if !CONFIG_FS_EVENTS?


-serge
