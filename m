Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbULUShe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbULUShe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbULUShe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:37:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:19387 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261836AbULUSh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:37:29 -0500
Date: Tue, 21 Dec 2004 10:37:10 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add mmap support to struct bin_attribute files
Message-ID: <20041221183710.GA8490@kroah.com>
References: <200412210932.54961.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412210932.54961.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 09:32:54AM -0800, Jesse Barnes wrote:
> This patch adds an mmap method and some more error checking to struct 
> bin_attribute--good for things like exporting PCI resources directly.  I 
> wasn't sure about the return values for the case where an attribute is 
> missing a given method, and it looks like mm.h can't be included in sysfs.h, 
> so I had to forward declare struct vm_area_struct.  Other than that, it works 
> fine for my test cases.
> 
>  fs/sysfs/bin.c        |   27 +++++++++++++++++++++++++--
>  include/linux/sysfs.h |    6 ++++++
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Nice, thanks for doing this.  I've applied it to my trees.

greg k-h
