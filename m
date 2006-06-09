Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWFICp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWFICp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 22:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWFICp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 22:45:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965105AbWFICp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 22:45:26 -0400
Date: Thu, 8 Jun 2006 19:45:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 5/13] extents and 48bit ext3: sector_t type format string
Message-Id: <20060608194520.c7de1ee4.akpm@osdl.org>
In-Reply-To: <1149816130.4066.67.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816130.4066.67.camel@dyn9047017069.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2006 18:22:09 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> 
> 
> Define SECTOR_FMT to print sector_t in proper format
> 
> ...
>
>  #define HAVE_SECTOR_T
>  typedef u64 sector_t;
> +#define SECTOR_FMT "%llu"

We did try this a few years ago, but I cannot for the life of me remember
our reasons for abandoning it :(

We ended up deciding that the best way of handling this is to open-code the
%lld and to typecast the argument to long long.
