Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUEFVlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUEFVlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUEFVlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:41:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:50839 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263088AbUEFVlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:41:08 -0400
Date: Thu, 6 May 2004 14:40:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: FabF <Fabian.Frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6-rc3-mm2] genhd-unregister warn handling
Message-Id: <20040506144045.0711b4db.akpm@osdl.org>
In-Reply-To: <1083866562.5865.6.camel@bluerhyme.real3>
References: <1083866562.5865.6.camel@bluerhyme.real3>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF <Fabian.Frederick@skynet.be> wrote:
>
> 	Here's a patch against 2.6.6-rc3-mm2 genhd.c unregister_blkdev
> 
>  	-Standardize function for void xxx
>  	-Split uncorresponding return
>  	-Add printks
>  	-Merge kfree to positive case
> 
>  	Could you apply ?

It seems to be a gratuitous change to the modules API.

A quick grep shows that a lot of drivers are currently testing the
unregister_blkdev() return value - your patch breaks them all.

I don't see much point in making changes in this area. 
