Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTG1LbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbTG1La2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:30:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15497
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263738AbTG1L2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:28:50 -0400
Subject: Re: [PATCH] Remove module reference counting.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, arjanv@redhat.com,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030727193919.832302C450@lists.samba.org>
References: <20030727193919.832302C450@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059392407.15458.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jul 2003 12:40:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-27 at 20:34, Rusty Russell wrote:
> In message <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org> you write:
> > 
> > First off - we're not changing fundamental module stuff any more.
> 
> OK.  Who are you and what have you done with the real Linus?
> 
> I guess it's back to fixing up reference counting in the rest of the
> kernel.  It's not hard, it's just not done. 8(

Right but it wasnt in 2.2 or 2.4 and its root only. If you want to be
really paranoid add a 

MODULE_UNLOADABLE 

that people can add to their modules that do unload safely (ie most of
them) as and when they check them over.

