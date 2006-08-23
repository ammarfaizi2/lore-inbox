Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbWHWUFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWHWUFB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 16:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWHWUFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 16:05:01 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:63906 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965175AbWHWUFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 16:05:00 -0400
Date: Wed, 23 Aug 2006 16:04:58 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sds@tycho.nsa.gov,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] SELinux: 1/3 eliminate inode_security_set_security
In-Reply-To: <1156362631.6662.48.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0608231604350.5728@d.namei>
References: <1156362631.6662.48.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006, Eric Paris wrote:

> inode_security_set_sid is only called by security_inode_init_security,
> which is called when a new file is being created and needs to have its
> incore security state initialized and its security xattr set.  This
> helper used to be called in other places in the past, but now only has
> the one.  So this patch rolls inode_security_set_sid directly back into
> security_inode_init_security.  There also is no need to hold the
> isec->sem while doing this, as the inode is not available to other
> threads at this point in time.
> 
> This is being targeted for 2.6.19
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>
