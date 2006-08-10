Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWHJUeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWHJUeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWHJUeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:34:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751576AbWHJUdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:33:45 -0400
Date: Thu, 10 Aug 2006 13:33:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
Message-Id: <20060810133338.8d1f6061.akpm@osdl.org>
In-Reply-To: <44DB9582.6010609@garzik.org>
References: <1155172622.3161.73.camel@localhost.localdomain>
	<20060809233914.35ab8792.akpm@osdl.org>
	<44DB61D7.1000109@us.ibm.com>
	<20060810111839.51c73911.akpm@osdl.org>
	<44DB9582.6010609@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 16:22:26 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> I strongly disagree that ext3 should be subject to a spring cleaning. 
> Comments, whitespace, very very minor things, sure.  Trying to get rid 
> of brelse() when _many_ other filesystems also use it?  ext4 material.

We should seek to minimise the difficulty of cross-porting bugfixes and
enhancements.  Putting cleanups in only ext4 works against that.

ext3 will be around for many years yet.  We cannot just let it rot due to
some false belief that performing routine maintenance against it will for
some magical reason cause it to break.

