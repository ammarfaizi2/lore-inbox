Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWJVSje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWJVSje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJVSje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:39:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:60395 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750747AbWJVSjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:39:33 -0400
Date: Sun, 22 Oct 2006 11:39:24 -0700
From: Greg KH <gregkh@suse.de>
To: Thomas Maier <balagi@justmail.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6.19-rc2-mm2 sysfs: sysfs_write_file() writes zero terminated data
Message-ID: <20061022183924.GA18032@suse.de>
References: <op.tht1yneaiudtyh@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.tht1yneaiudtyh@master>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 07:17:47PM +0200, Thomas Maier wrote:
> Hello,
> 
> since most of the files in sysfs are text files,
> it would be nice, if the "store" function called
> during sysfs_write_file() gets a zero terminated
> string / data.
> The current implementation seems not to ensure this.
> (But only if it is the first time the zeroed buffer
> page is allocated.)

Have you seen sysfs buffers being passed to the store() function in a
non-null terminated manner?  How?

Are you seeking backward and then writing again to the file somehow?

thanks,

greg k-h
