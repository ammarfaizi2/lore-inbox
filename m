Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbTFEUIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbTFEUIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:08:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:60366 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265107AbTFEUIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:08:43 -0400
Date: Thu, 5 Jun 2003 12:48:26 -0700
From: Greg KH <greg@kroah.com>
To: Andreas Schultz <aschultz@warp10.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][I2C] fix unsafe usage of list_for_each in i2c-core
Message-ID: <20030605194826.GB6238@kroah.com>
References: <200306052048.21409.aschultz@warp10.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306052048.21409.aschultz@warp10.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 08:48:21PM +0200, Andreas Schultz wrote:
> Hi,
> 
> i2c-core.c contains 2 loops that iterate over the list of the clients attached 
> to an adapter and detaches them. Detaching the clients will actually remove 
> them from the list the loop is iterating over. Therefore the 
> list_for_each_safe() method has to be used.

Ah, nice catch.  Applied, thanks.

I'm guessing this fixes your other i2c problems you were having?

thanks,

greg k-h
