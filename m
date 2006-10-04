Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161812AbWJDROx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161812AbWJDROx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161859AbWJDROx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:14:53 -0400
Received: from flvpn.ccur.com ([66.10.65.2]:24519 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1161812AbWJDROw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:14:52 -0400
Date: Wed, 4 Oct 2006 13:14:36 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Reinette Chatre <reinette.chatre@linux.intel.com>,
       linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky@linux.intel.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of a user buffer
Message-ID: <20061004171436.GA25461@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <200610030816.27941.reinette.chatre@linux.intel.com> <20061003163936.d8e26629.akpm@osdl.org> <20061004141405.GA22833@tsunami.ccur.com> <20061004094029.cdfef098.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004094029.cdfef098.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 09:40:29AM -0700, Andrew Morton wrote:
> I think we can do a version which omits the kmalloc altogether:

> 			if (__get_user(c, ubuf++))
> 				return -EFAULT;
> 
> (Note the s/get_user/__get_user/)

Nice.  This eliminates the bulk of the get_user() overhead.  And
it can be merged into Inaky's enum solution too, for something
that is both simple and efficient.

Joe
