Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTIOXJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTIOXJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:09:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:61153 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261680AbTIOXJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:09:38 -0400
Date: Mon, 15 Sep 2003 16:09:49 -0700
From: Greg KH <greg@kroah.com>
To: Kendrick Hamilton <hamilton@sedsystems.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI probe, please CC hamilton@sedsystems.ca
Message-ID: <20030915230949.GA18153@kroah.com>
References: <3F66441F.3010206@sedsystems.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F66441F.3010206@sedsystems.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 04:58:39PM -0600, Kendrick Hamilton wrote:
> Hello,
>    we are using the Linux 2.2.16 kernel (some of the code we purchased 
> does not work with 2.4.x kernels and we would have to do a lot of 
> regression testing to upgrade) on an IBM e-server. We wrote a module for 
> a modulator card we are using. The code uses pci_find_device to find the 
> modulator cards. The problem we are having is that it finds the cards in 
> different orders. One time hss0 is the card in slot 4 and hss1 is the 
> card in slot5. The next time we power up the computer, hss0 is the card 
> in slot5 and hss1 is the card in slot 4.
>    The IBM e-server has about 5 PCI bridges.
>    Do you have any suggestion as to how I might be able to ensure the 
> cards are always detected in the same order? Our system requires that 
> they always be in the same order.

Are the pci device ids different across different boots?  If not, is
there any way you can tie a specific device to a specific interface
(unique hardware addresses, mac addresses, etc.)?

thanks,

greg k-h
