Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVATQDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVATQDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 11:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVATQDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:03:38 -0500
Received: from pD95620DD.dip.t-dialin.net ([217.86.32.221]:51007 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262162AbVATQAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:00:17 -0500
Date: Thu, 20 Jan 2005 17:00:05 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] mips default mlock limit fix
Message-ID: <20050120160005.GA5672@linux-mips.org>
References: <20050119175945.K469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119175945.K469@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 05:59:45PM -0800, Chris Wright wrote:

> Mips RLIMIT_MEMLOCK incorrectly defaults to unlimited, it was confused
> with RLIMIT_NPROC.  Found while consolidating resource.h headers.

Thanks, I applied a recent change off by one line.  To avoid this I've
changed the code to use named initializers, see

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-cvs-patches&i=95f18dfc8e770c9885b796a676935677%40NO-ID-FOUND.mhonarc.org

  Ralf
