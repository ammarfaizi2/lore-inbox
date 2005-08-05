Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbVHEWCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbVHEWCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbVHEWCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:02:30 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:39029 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261968AbVHEWAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:00:42 -0400
Date: Fri, 5 Aug 2005 15:00:15 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: yhlu <yhlu.kernel@gmail.com>, Roland Dreier <rolandd@cisco.com>,
       linville@tuxdriver.com, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
Subject: Re: mthca and LinuxBIOS
Message-ID: <20050805220015.GA3524@suse.de>
References: <86802c440508041230143354c2@mail.gmail.com> <52slxp6o5b.fsf@cisco.com> <86802c440508051103500f6942@mail.gmail.com> <86802c4405080511079d01532@mail.gmail.com> <52psss5k1x.fsf@cisco.com> <86802c44050805112661d889aa@mail.gmail.com> <86802c4405080512254b9cd496@mail.gmail.com> <86802c4405080512451cdcae48@mail.gmail.com> <86802c44050805132853070f1@mail.gmail.com> <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 01:38:37PM -0700, Linus Torvalds wrote:
> 
> Hmm.. This looks half-way sane, but too ugly for words.
> 
> I'd much rather see that when we detect a 64-bit resource, we always mark 
> the next resource as being reserved some way, and then we just make 
> pci_update_resource() ignore such reserved resources.
> 
> The
> 
> 		if((resno & 1)==1) {
> 			/* check if previous reg is 64 mem */
> 			..
> 
> stuff is really too ugly.

Yeah, that's not nice.

But what's the real problem we are trying to fix here?  I seem to have
missed that in the email thread somehow.

> Greg? Ivan?

Ivan's the pci resource guru, any thoughts as to how to do this in a
nicer way?

thanks,

greg k-h
