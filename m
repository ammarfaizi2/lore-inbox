Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTLUBIi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 20:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTLUBIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 20:08:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:42138 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262009AbTLUBIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 20:08:37 -0500
Date: Sat, 20 Dec 2003 17:01:55 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make ppp_async callable from hard interrupt
Message-ID: <20031221010152.GA3025@kroah.com>
References: <16356.60597.133074.809551@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16356.60597.133074.809551@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 11:43:33AM +1100, Paul Mackerras wrote:
> Since there are serial drivers (particularly the USB serial driver)
> that call the line discipline receive_buf and write_wakeup routines at
> hard interrupt level, I have changed the ppp_async code to cope with
> that.  It now uses a tasklet so that it calls the generic PPP code at
> soft interrupt level even if its receive_buf and write_wakeup entries
> are called at hard interrupt level.

Ah, nice.  Does this mean I can take the "make usb serial drivers use a
tasklet to handle received data" entry off of my todo list now?  :)

thanks,

greg k-h
