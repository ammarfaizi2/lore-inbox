Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSFTWHu>; Thu, 20 Jun 2002 18:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSFTWHt>; Thu, 20 Jun 2002 18:07:49 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:22800 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315629AbSFTWHr>;
	Thu, 20 Jun 2002 18:07:47 -0400
Date: Thu, 20 Jun 2002 15:06:21 -0700
From: Greg KH <greg@kroah.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, david-b@pacbell.net
Subject: Re: [linux-usb-devel] [PATCHlet] 2.5.23 usb, ide
Message-ID: <20020620220620.GI1470@kroah.com>
References: <UTC200206201849.g5KInaK27367.aeb@smtp.cwi.nl> <8A6B34966F9@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A6B34966F9@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 23 May 2002 20:28:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 09:40:27PM +0200, Petr Vandrovec wrote:
> On 20 Jun 02 at 20:49, Andries.Brouwer@cwi.nl wrote:
> > 
> > Now that you tell me that these things are set at initialization
> > and never changed, the initialization must be wrong. And indeed,
> > it says "__devexit_p(uhci_stop)" and this yields NULL.
> 
> Now when kernel tries to shutdown devices on poweroff, should
> not we change __devexit_p() meaning? Like always build kernel with
> hotplug enabled?

You should always enable CONFIG_HOTPLUG anyway :)

Seriously, you are correct, we will probably have to go back and audit
the __devexit functions when we put poweroff support in.

thanks,

greg k-h
