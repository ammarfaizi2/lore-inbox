Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVLPGvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVLPGvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 01:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVLPGvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 01:51:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:7143 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932127AbVLPGvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 01:51:44 -0500
Date: Thu, 15 Dec 2005 21:17:01 -0800
From: Greg KH <greg@kroah.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Vitaly Wool <vwool@ru.mvista.com>, David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       Joachim_Jaeger@digi.com
Subject: Re: [spi-devel-general] Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
Message-ID: <20051216051701.GA27796@kroah.com>
References: <20051215223322.GA8578@kroah.com> <20051216033459.GA5460@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216033459.GA5460@hexapodia.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 07:34:59PM -0800, Andy Isaacson wrote:
> Now one could argue that this design is broken (requiring a slow serial
> bus access to ack an irq means that you end up with very high-latency
> interrupt handlers) but it's my impression that such designs are not
> unheard of in the embedded world.

Then you just atomically allocate a buffer like all of the current
kernel drivers do :)

Come on people, this really isn't an issue...

thanks,

greg k-h
