Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030546AbVKCXvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbVKCXvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbVKCXvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:51:23 -0500
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:235 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030546AbVKCXvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:51:23 -0500
Date: Thu, 3 Nov 2005 18:51:25 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Phillip Hellewell <phillip@hellewell.homeip.net>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
Subject: Re: [PATCH 9/12: eCryptfs] Inode operations
In-Reply-To: <20051103035411.GI3005@sshock.rn.byu.edu>
Message-ID: <Pine.LNX.4.63.0511031850220.22256@excalibur.intercode>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035411.GI3005@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Phillip Hellewell wrote:

> +static int grow_file(struct dentry *ecryptfs_dentry, struct file *lower_file,
> +		     struct inode *inode, struct inode *lower_inode)
> +{
> +	int rc = 0;
> +	struct file fake_file;
> +	memset(&fake_file, 0, sizeof(fake_file));


You don't need these initializations, bss is always initialized to zero 
in this environment.


- James
-- 
James Morris
<jmorris@namei.org>
