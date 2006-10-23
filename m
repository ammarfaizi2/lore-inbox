Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWJWPe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWJWPe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWJWPe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:34:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43405 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964918AbWJWPe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:34:28 -0400
Date: Mon, 23 Oct 2006 17:32:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Message-ID: <20061023153257.GC8414@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161576857.3466.9.camel@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Switch from bitmaps to using extents to record what swap is allocated;
> they make more efficient use of memory, particularly where the allocated
> storage is small and the swap space is large.

> This is also part of the ground work for implementing support for
> supporting multiple swap devices.

bitmaps were more efficient and longer than original code... I did not
_like_ them, but they are in now. I'd hate to change the code again,
for what, 0.5% gain?

...and this is still longer than bitmaps.

And SNAPSHOT_GET_SWAP_PAGE seems to support multiple swap spaces
already.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
