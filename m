Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVDRQ03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVDRQ03 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVDRQ03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:26:29 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:43418 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262105AbVDRQ0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:26:12 -0400
Message-ID: <4263DF70.2060702@ammasso.com>
Date: Mon, 18 Apr 2005 11:25:20 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Roland Dreier <roland@topspin.com>, Troy Benjegerdes <hozer@hozed.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	 <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>	 <4263DBBF.9040801@ammasso.com> <1113840973.6274.84.camel@laptopd505.fenrus.org>
In-Reply-To: <1113840973.6274.84.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> this is a myth; linux is free to move the page about in physical memory
> even if it's mlock()ed!!

Then Linux has a very odd definition of the word "locked".

> And even then, the user can munlock the memory from another thread etc
> etc. Not a good idea.

Well, that's okay, because then the app is doing something stupid, so we don't worry about 
that.

> get_user_pages() is used from AIO and other parts of the kernel for
> similar purposes and in fact is designed for it, so it better work. If
> it has bugs those should be fixed, not worked around!

I've been complaining about get_user_pages() not working for a long time now, but I can 
only demonstrate the problem with our hardware.  See my other post in this thread for details.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
