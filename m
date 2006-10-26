Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945971AbWJZXb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945971AbWJZXb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945991AbWJZXb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:31:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945971AbWJZXb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:31:58 -0400
Date: Thu, 26 Oct 2006 16:31:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, iss_storagedev@hp.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH cciss: fix printk format warning
Message-Id: <20061026163152.9fcdd8fc.akpm@osdl.org>
In-Reply-To: <ada64e67jhf.fsf@cisco.com>
References: <20061023214608.f09074e9.randy.dunlap@oracle.com>
	<20061026160245.26f86ce2.akpm@osdl.org>
	<ada64e67jhf.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006 16:19:56 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>  > >  	if (*total_size != (__u32) 0)
>  > 
>  > Why is cciss_read_capacity casting *total_size to u32?
> 
> It's not -- it's actually casting 0 to __32

bah.

> -- there's no cast on the
> *total_size side of the comparison.  However that just makes the cast
> look even fishier.

yup, it's harmless.  Just something which was put in there to entertain passers-by.
