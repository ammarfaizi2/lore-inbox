Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbVAKWpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVAKWpC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVAKWnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:43:11 -0500
Received: from waste.org ([216.27.176.166]:12729 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262875AbVAKWjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:39:08 -0500
Date: Tue, 11 Jan 2005 14:39:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI patches for 2.6.10
Message-ID: <20050111223902.GJ2995@waste.org>
References: <20050110171827.GA30296@kroah.com> <11053776551683@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11053776551683@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 09:20:55AM -0800, Greg KH wrote:
> ChangeSet 1.1938.439.44, 2005/01/07 10:32:39-08:00, domen@coderock.org
> 
> [PATCH] hotplug/acpiphp_ibm: module_param fix
> 
> File permissins should be octal number.

> -module_param(debug, bool, 644);
> +module_param(debug, bool, 0644);

Perhaps the sysfs code could do:

	/* did we forget to write in octal? */
	BUG_ON(mode > 0666 || mode & 0111);

-- 
Mathematics is the supreme nostalgia of our time.
