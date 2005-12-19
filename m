Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVLSRHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVLSRHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVLSRHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:07:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:21388 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964864AbVLSRHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:07:01 -0500
Date: Mon, 19 Dec 2005 09:00:05 -0800
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] SPI core: turn transfers to be linked list
Message-ID: <20051219170005.GA1911@kroah.com>
References: <43A480C0.9080201@ru.mvista.com> <200512181240.46841.david-b@pacbell.net> <43A665F7.7020404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A665F7.7020404@ru.mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 10:49:11AM +0300, Vitaly Wool wrote:
> The problem is: we're using real-time enhancements patch developed by 
> Ingo/Sven/Daniel etc. You cannot call kmalloc from the interrupt 
> context  if you're using this patch.

So you can't even call:
	kmalloc(sizeof(foo), GFP_ATOMIC);
in an interrupt anymore?
If so, that's going to break mainline pretty bad...

thanks,

greg k-h
