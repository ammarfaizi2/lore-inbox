Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVK1U6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVK1U6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVK1U6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:58:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:33747 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751174AbVK1U6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:58:39 -0500
Date: Mon, 28 Nov 2005 12:49:50 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Updates to sysfs_create_subdir()
Message-ID: <20051128204950.GC17740@kroah.com>
References: <Pine.LNX.4.50.0511231336261.16769-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0511231336261.16769-100000@monsoon.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 01:56:29PM -0800, Patrick Mochel wrote:
> 
> The patch below addresses this issue by parsing the subdirectory name and
> creating any parent directories delineated by a '/'.

Generally I never liked parsing stuff like this in the kernel (proc and
devfs both do this).  That being said, I do see the need to make subdirs
like this easier.

But what about cleanups?  If I create an attribute group "foo/baz/x/" and
then remove it, will the subdirectories get cleaned up too?  What about
if I had created a group "foo/baz/y/" after the "x" one?  Or just
"foo/baz"?

thanks,

greg k-h
