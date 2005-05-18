Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVERF3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVERF3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 01:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVERF3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 01:29:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38557 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262096AbVERF3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 01:29:24 -0400
Date: Wed, 18 May 2005 06:29:40 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/9] UML - small fixes left over from rc4
Message-ID: <20050518052940.GE29811@parcelfarce.linux.theplanet.co.uk>
References: <200505180420.j4I4K5CS017303@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505180420.j4I4K5CS017303@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 12:20:05AM -0400, Jeff Dike wrote:
> --- linux-2.6.12-rc.orig/arch/um/Kconfig_x86_64	2005-05-17 16:36:27.000000000 -0400
> +++ linux-2.6.12-rc/arch/um/Kconfig_x86_64	2005-05-17 16:37:06.000000000 -0400
> @@ -6,6 +6,10 @@ config 64BIT
>  	bool
>  	default y
>  
> +config TOP_ADDR
> + 	hex
> +	default 0x60000000
> +

Wrong.  If you want it to work, you need 0x80000000 here (or changed START
in x86_64 makefile.

ACK for the rest.
