Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUCCFn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUCCFn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:43:58 -0500
Received: from adsl-186.flex.com ([206.126.1.185]:12416 "EHLO mail.imodulo.com")
	by vger.kernel.org with ESMTP id S262381AbUCCFny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:43:54 -0500
Date: Tue, 2 Mar 2004 19:43:52 -1000
From: Glen Nakamura <glen@imodulo.com>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mysterious string truncation in 2.4.25 kernel
Message-ID: <20040303054352.GA3571@modulo.internal>
References: <20040302235353.GA4215@modulo.internal> <Xine.LNX.4.44.0403022302030.31759-100000@thoron.boston.redhat.com> <20040303053547.GA3160@modulo.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303053547.GA3160@modulo.internal>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 07:35:47PM -1000, Glen Nakamura wrote:
> void __init mount_devfs_fs (void)
> {
>     int err;
> 
>     if ( !(boot_options & OPTION_MOUNT) ) return;
>+    err = do_mount ("none", "/dev", "devfs", 0, "");
>     if (err == 0) printk (KERN_INFO "Mounted devfs on /dev\n");
>     else PRINTK ("(): unable to mount devfs, err: %d\n", err);
> }   /*  End Function mount_devfs_fs  */

Whoops... I deleted the do_mount line by accident.

- glen
