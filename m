Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbQL3C7G>; Fri, 29 Dec 2000 21:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbQL3C65>; Fri, 29 Dec 2000 21:58:57 -0500
Received: from hermes.mixx.net ([212.84.196.2]:20494 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131205AbQL3C6r>;
	Fri, 29 Dec 2000 21:58:47 -0500
Message-ID: <3A4D47B2.D89015CB@innominate.de>
Date: Sat, 30 Dec 2000 03:25:54 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: test13-pre6
In-Reply-To: <Pine.LNX.4.10.10012291609470.1123-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Ok, there's a test13-pre6 out there now, which does a partial sync with
> Alan, in addition to hopefully fixing the innd shared mapping writeback
> problem for good.  Thanks to Marcelo Tosatti and others..

After the page_cache_release at line 574 of vmscan.c the page is
unlocked and only owned by the page cache - anything could happen.  How
do you know the set_page_dirty at line 581 is still hitting a valid
page?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
