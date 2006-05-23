Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWEWSr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWEWSr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWEWSr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:47:27 -0400
Received: from ns2.suse.de ([195.135.220.15]:50317 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932093AbWEWSr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:47:26 -0400
Date: Tue, 23 May 2006 11:45:06 -0700
From: Greg KH <greg@kroah.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
Message-ID: <20060523184506.GA29044@kroah.com>
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 07:04:32PM -0400, Theodore Ts'o wrote:
> --- linux-2.6.orig/kernel/panic.c	2006-04-28 21:16:55.000000000 -0400
> +++ linux-2.6/kernel/panic.c	2006-05-21 19:00:15.000000000 -0400
> @@ -150,6 +150,7 @@
>   *  'R' - User forced a module unload.
>   *  'M' - Machine had a machine check experience.
>   *  'B' - System has hit bad_page.
> + *  'U' - Userspace-defined naughtiness.

Just a note, some other distros already use the 'U' flag in taint
messages to show an "unsupported" module has been loaded.  I know it's
out-of-the-tree and will never go into mainline, just FYI if you happen
to see some 'U' flags in the wild today...

Oh, and I like this feature, makes sense to me to have this.

thanks,

greg k-h
