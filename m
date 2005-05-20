Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVETFMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVETFMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 01:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVETFMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 01:12:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:55500 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261334AbVETFL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 01:11:58 -0400
Date: Thu, 19 May 2005 22:18:39 -0700
From: Greg KH <greg@kroah.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
Message-ID: <20050520051839.GB10394@kroah.com>
References: <20050519164323.GK3771@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050519164323.GK3771@smtp.west.cox.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 09:43:23AM -0700, Tom Rini wrote:
> If CONFIG_INPUT is set as a module, it will not load as hotplug_path is
> not a defined symbol.  Trivial fix is to EXPORT_SYMBOL hotplug_path.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Ick, no, I thought we got rid of that usage.  no one should be calling
hotplug on their own, lots of bad things happen to udevd and HAL if they
do.

What caused the input code to be added back into the kernel?  I'll try
to go track that down...

thanks,

greg k-h
