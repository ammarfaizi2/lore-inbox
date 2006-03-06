Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWCFWjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWCFWjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWCFWjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:39:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932414AbWCFWjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:39:09 -0500
Date: Mon, 6 Mar 2006 14:37:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16-rc5-mm2 mpage_readpages() cleanup
Message-Id: <20060306143718.50fc0d94.akpm@osdl.org>
In-Reply-To: <1141684312.17095.11.camel@dyn9047017100.beaverton.ibm.com>
References: <1141684312.17095.11.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Instead of passing validity of block mapping, do_mpage_readpage() 
>  can figure it out using buffer_mapped(). This will reduce one
>  un-needed argument passing.

Is buffer_mapped() the correct flag to use?  Remember that get_block() can
validly return a !buffer_mapped() bh over a file hole.

Either way, there should be a comment in there explaining the protocol,
please.

