Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbUCRMQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbUCRMQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:16:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21952 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262557AbUCRMQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:16:51 -0500
Date: Thu, 18 Mar 2004 12:16:50 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 2/5
Message-ID: <20040318121650.GI31500@parcelfarce.linux.theplanet.co.uk>
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org> <20040315075723.GD31818@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315075723.GD31818@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 08:57:23AM +0100, Herbert Poetzl wrote:
> -void update_atime(struct inode *inode)
> +void update_atime(struct inode *inode, struct vfsmount *mnt)

_Hell_, no.  Proper solution is to move the callers upstream instead
of propagating vfsmounts downstream.  That, BTW, was the main reason
for readdir() patch.

BTW, update_atime() is exported.  And it's 2.6 now...
