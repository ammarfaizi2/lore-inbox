Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVLGQmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVLGQmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVLGQmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:42:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:29603 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751193AbVLGQmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:42:07 -0500
Date: Wed, 7 Dec 2005 08:41:18 -0800
From: Greg KH <gregkh@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-ID: <20051207164118.GA28032@suse.de>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 09:56:10AM -0200, Luiz Fernando Capitulino wrote:
>  Greg,
> 
>  Don't get scared. :-)

I'm not scared, just not liking this patch series at all.

In the end, it's just moving from one locking scheme to another.  No big
deal.

The problem is, none of this should be needed at all.  We need to move
the usb-serial drivers over to use the serial core code.  If that
happens, then none of this locking is needed.

That's the right thing to do, so I'm not going to take this patch series
right now because of that.  If you all want to work on moving to use the
serial core, I would love to see that happen.

thanks,

greg k-h
