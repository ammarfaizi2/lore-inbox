Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTJDAkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 20:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbTJDAkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 20:40:08 -0400
Received: from mail.kroah.org ([65.200.24.183]:50326 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261586AbTJDAkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 20:40:06 -0400
Date: Fri, 3 Oct 2003 17:30:43 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A bug (and a fix) in usbserial.c, kernel 2.4.22
Message-ID: <20031004003043.GA4489@kroah.com>
References: <20031004021535.7a92476e.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031004021535.7a92476e.zap@homelink.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 02:15:35AM +0400, Andrew Zabolotny wrote:
> The __serial_close function is setting port->tty to NULL, so the
> solution is to remove either the line 559:
> 
> ...
> port->open_count = 0;
> port->tty = NULL;
> ...
> 
> or line 1408 (which seems a better solution to me).

Or see the patch that is already in the 2.4.23-pre kernel tree :)

thanks,

greg k-h
