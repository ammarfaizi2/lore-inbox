Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269097AbUIHKrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269097AbUIHKrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269098AbUIHKrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:47:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3291 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269097AbUIHKrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:47:39 -0400
Date: Wed, 8 Sep 2004 11:47:39 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] to add device+inode check to ipt_owner.c - HACKED UP
Message-ID: <20040908104739.GX23987@parcelfarce.linux.theplanet.co.uk>
References: <20040908100946.GA9795@lkcl.net> <20040908103922.GD9795@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908103922.GD9795@lkcl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 11:39:22AM +0100, Luke Kenneth Casson Leighton wrote:
> +static int
> +match_inode(const struct sk_buff *skb, const char *devname, unsigned long i_num)
> +{
> +	struct task_struct *g, *p;
> +	struct files_struct *files;
> +	/*
> +	struct inode *inode;
> +	struct super_block *sb;
> +	struct block_device *bd;
> +	*/
> +	int i;
> +	read_lock(&tasklist_lock);
> +
> +	/* lkcl: these are fairly obvious (just obtuse): hunt for the
> +	 * filesystem device, then its superblock, then the inode is
> +	 * relevant to that superblock, _then_ we can find the inode.
> +	bd = bdget(dev);


... the hell?  Where does that "dev" come from?
