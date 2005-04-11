Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVDKU1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVDKU1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVDKU0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:26:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:25763 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261946AbVDKUU3 (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:20:29 -0400
Date: Mon, 11 Apr 2005 13:03:18 -0700
From: Greg KH <greg@kroah.com>
To: Derek Cheung <derek.cheung@sympatico.ca>
Cc: "'Randy.Dunlap'" <rddunlap@osdl.org>, "'Andrew Morton'" <akpm@osdl.org>,
       Linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Message-ID: <20050411200318.GA25550@kroah.com>
References: <42535AF1.5080008@osdl.org> <000801c53ded$04428920$1501a8c0@Mainframe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000801c53ded$04428920$1501a8c0@Mainframe>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 12:47:42PM -0400, Derek Cheung wrote:
> Enclosed please find the updated patch that incorporates changes for all
> the comments I received.

You did not cc: the sensors mailing list, nor fix all of the coding
style issues.

> The volatile declaration in the m528xsim.h is needed because the
> declaration refers to the ColdFire 5282 register mapping.

Shouldn't you be calling ioremap, and not directly accessing a specific
register location through a pointer?  That's how all other arches do
this.

thanks,

greg k-h
