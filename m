Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVFAE3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFAE3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 00:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFAE3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 00:29:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:11985 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261250AbVFAE3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 00:29:07 -0400
Date: Tue, 31 May 2005 21:39:18 -0700
From: Greg KH <greg@kroah.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Introduce tty_unregister_ldisc()
Message-ID: <20050601043918.GA26532@kroah.com>
References: <200505312356.00853.adobriyan@gmail.com> <1117578491.4627.14.camel@at2.pipehead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117578491.4627.14.camel@at2.pipehead.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 05:28:11PM -0500, Paul Fulghum wrote:
> This patch is wrong. Please do not apply.
> 
> An unmodified ldisc driver (externally maintained) will continue to call
> tty_register_ldisc with NULL, but the new behavior will be to set the
> ldisc pointer to NULL but have LDISC_FLAG_DEFINED set.

Then fix that code.  We can not do anything about externally maintained
code, sorry.  

> If you feel it is absolutely necessary to add this new function
> for cosmetic reasons, then leave the old behavior in place
> and make tty_unregister_ldisc a wrapper to tty_register_ldisc
> that uses a NULL pointer.
> 
> This preserves sanity and compatibility.

We don't care about compatibility in order to keep our sanity.  See
Documentation/stable_api_nonsense.txt for details :)

thanks,

greg k-h
