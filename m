Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131502AbRCWWlh>; Fri, 23 Mar 2001 17:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRCWWkI>; Fri, 23 Mar 2001 17:40:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26387 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131489AbRCWWii>; Fri, 23 Mar 2001 17:38:38 -0500
Date: Fri, 23 Mar 2001 14:37:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Stephen C. Tweedie" <sct@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Ben LaHaise <bcrl@redhat.com>,
        Christoph Rohland <cr@sap.com>
Subject: Re: [PATCH] Fix races in 2.4.2-ac22 SysV shared memory
In-Reply-To: <E14ga9U-0005aa-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0103231435000.766-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Mar 2001, Alan Cox wrote:
>
> __find_get_page has I think a misleading comment ?

Ehh..

I only said the _naming_ makes sense. [ Wild hand-waving ]

I suspect that what happened was that we split off the functions (one to
just get the page, one to lock it), and the comment that was associated
with the original "find_page()" never got removed, and just happens to sit
above one of the helper functions now - the one that didn't lock.

I'll fix the comment.

		Linus

