Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVAUWIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVAUWIc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVAUWHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:07:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:27366 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262547AbVAUWGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:06:43 -0500
Date: Fri, 21 Jan 2005 14:06:30 -0800
From: Greg KH <greg@kroah.com>
To: "Williams, Mitch A" <mitch.a.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysfs write fixes
Message-ID: <20050121220630.GA3231@kroah.com>
References: <F3EE2A9EB4576F40AFE238EC0AC04BC50488BA12@orsmsx402.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F3EE2A9EB4576F40AFE238EC0AC04BC50488BA12@orsmsx402.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 01:44:45PM -0800, Williams, Mitch A wrote:
> This patch corrects some errors that we saw while writing to sysfs
> files.
>  - Attempts to open the file in append mode result in error
>  - Writes are buffered and flushed to the kobject owner during close
>  - Attempts to seek on sysfs files result in error
> 
> Generated from 2.6.11-rc1.
> 
> It's not a big patch, but if you'd like it whacked up into smaller ones,
> I'll
> be glad to do so.

Please split it up into different patches in different emails.  Also,
fix your email client, the patch was line wrapped.

And don't add this:

> @@ -1,5 +1,11 @@
>  /*
>   * file.c - operations for regular (text) files.
> + *
> + * Changes:
> + * 2004/01/21 Mitch Williams <mitch.a.williams at intel.com>
> + *   - Changed llseek method to be no_llseek.
> + *   - Opening a file for append now returns an error.
> + *   - Writes are now buffered and flushed at close
>   */

Changes show up in the change log comments, not within the files.
Otherwise, over time they grow out of control.

thanks,

greg k-h
