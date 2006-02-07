Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWBGA2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWBGA2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBGA2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:28:33 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:40605 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932423AbWBGA2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:28:31 -0500
Message-ID: <43E7E998.2020007@vilain.net>
Date: Tue, 07 Feb 2006 13:28:08 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>  <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru>  <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <43E61448.7010704@sw.ru> <Pine.LNX.4.64.0602060847130.3854@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602060847130.3854@g5.osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> So if some people don't like "container", how about just calling it 
> "context"? The downside of that name is that it's very commonly used in 
> the kenel, because a lot of things have "contexts". That's why "container" 
> would be a lot better.
> 
> I'd suggest
> 
> 	current->container	- the current EFFECTIVE container
> 	current->master_container - the "long term" container.
> 
> (replace "master" with some other non-S&M term if you want)

Hmm.  You actually need a linked list, otherwise you have replaced a one
level flat structure with a two level one, and you miss out on some of
the applications.  VServer uses a special structure for this.

Sam.
