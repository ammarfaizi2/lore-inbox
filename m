Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTLUBLm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 20:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTLUBLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 20:11:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:16539 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262040AbTLUBLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 20:11:39 -0500
Date: Sat, 20 Dec 2003 17:07:10 -0800
From: Greg KH <greg@kroah.com>
To: davidm@hpl.hp.com
Cc: ganesh@veritas.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: quick hack to make ipaq USB serial driver work again
Message-ID: <20031221010710.GB3025@kroah.com>
References: <200312200152.hBK1q0I4016741@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312200152.hBK1q0I4016741@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 05:52:00PM -0800, David Mosberger wrote:
> The ipaq USB driver in 2.6.0 didn't work for me.  I got the attached
> "Badness in local_bh_enable" backtrace when ppp tried to connect to my
> iPaq.  The quick and dirty patch to avoid the problem is this patch:

See Paul's patch on lkml today for the ppp code to fix this in a
"proper" way.  Or you can work on converting the usb-serial core to use
a tasklet instead of directly feeding the data upstream at
hard-interrupt time :)

thanks,

greg k-h
