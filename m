Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbULGCtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbULGCtE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 21:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbULGCtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 21:49:04 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:22781 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261745AbULGCs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 21:48:56 -0500
Date: Mon, 6 Dec 2004 18:52:18 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Phil Oester <kernel@linuxace.com>
Cc: shemminger@osdl.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Recent select() handling change breaks Poptop
Message-ID: <20041207025218.GB61527@gaz.sfgoth.com>
References: <20041207003525.GA22933@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207003525.GA22933@linuxace.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 06 Dec 2004 18:52:19 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester wrote:
> -       .poll =         datagram_poll,
> +       .poll =         udp_poll,
> 
> makes the Poptop server work again.
> 
> Any ideas?

That's very strange.  It would be helpful if you could gather:
  1. strace of the server, both working and broken
  2. a "tcpdump -nvv" of its udp traffic (ideally captured from a seperate
     server, but from the server would probably be OK too)

Most of the discussion of this change was on the netdev mailing list, it
would probably be best to send this information there.

-Mitch
