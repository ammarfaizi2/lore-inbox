Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWCAFhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWCAFhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 00:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWCAFhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 00:37:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57500 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932357AbWCAFhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 00:37:09 -0500
Date: Tue, 28 Feb 2006 21:35:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: ericvh@gmail.com (Eric Van Hensbergen)
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Subject: Re: [PATCH 1/3] v9fs: fix atomic create open
Message-Id: <20060228213559.7cb3a7a9.akpm@osdl.org>
In-Reply-To: <20060227041208.13E735A8075@localhost.localdomain>
References: <20060227041208.13E735A8075@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ericvh@gmail.com (Eric Van Hensbergen) wrote:
>
> +	if (inode)
> +		iput(inode);

iput(NULL) is legal.
