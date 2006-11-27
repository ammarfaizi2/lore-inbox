Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758530AbWK0Sty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758530AbWK0Sty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758531AbWK0Sty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:49:54 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:14512
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1758530AbWK0Stx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:49:53 -0500
Date: Mon, 27 Nov 2006 10:49:55 -0800 (PST)
Message-Id: <20061127.104955.48519839.davem@davemloft.net>
To: drepper@redhat.com
Cc: johnpol@2ka.mipt.ru, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com, hch@infradead.org, chase.venters@clientec.com,
       johann.borck@densedata.com, linux-kernel@vger.kernel.org,
       jeff@garzik.org, aviro@redhat.com
Subject: Re: Kevent POSIX timers support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <456B3016.9020706@redhat.com>
References: <456B2C82.7040700@redhat.com>
	<20061127.102443.74556125.davem@davemloft.net>
	<456B3016.9020706@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulrich Drepper <drepper@redhat.com>
Date: Mon, 27 Nov 2006 10:36:06 -0800

> David Miller wrote:
> > Now we'll have to have a compat layer for 32-bit/64-bit environments
> > thanks to POSIX timers, which is rediculious.
> 
> We already have compat_sys_timer_create.  It should be sufficient just 
> to add the conversion (if anything new is needed) there.  The pointer 
> value can be passed to userland in one or two int fields, I don't really 
> care.  When reporting the event to the user code we cannot just point 
> into the ring buffer anyway.  So while copying the data we can rewrite 
> it if necessary.  I see no need to complicate the code more than it 
> already is.

Ok, as long as that thing doesn't end up in the ring buffer entry
data structure, that's where the real troubles would be.
