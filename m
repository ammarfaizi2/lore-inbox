Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbTEOBQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTEOBQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:16:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63500 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263480AbTEOBQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:16:25 -0400
Date: Wed, 14 May 2003 18:28:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: ch@murgatroid.com, <inaky.perez-gonzalez@intel.com>, <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <20030514182526.36823e2b.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0305141827200.28093-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, Andrew Morton wrote:
> 
> I believe this effort is more targetted at teeny little embedded gadgets -
> devices which are very remote from workstations, desktops and servers.

And even there futexes are (a) faster and (b) smaller than SYSVIPC. So 
assuming you ever want threading in an embedded world (not unlikely at 
all, since things like DVD playback etc are mostly done with threads), you 
want futexes.

> Presumably the people who are programming such gadgets will know if they
> need futexes or not.

Yes. We can make tit a CONFIG option, and then force it to always be "y" 
in the .config file. And then the people who really know and really care 
can turn the "y" to a "n".

		Linus

