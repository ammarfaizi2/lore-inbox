Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbREUUUG>; Mon, 21 May 2001 16:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbREUUT4>; Mon, 21 May 2001 16:19:56 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:55300 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S261682AbREUUTk>;
	Mon, 21 May 2001 16:19:40 -0400
Message-ID: <20010520222320.B2647@bug.ucw.cz>
Date: Sun, 20 May 2001 22:23:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>, Ben LaHaise <bcrl@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH] device arguments from lookup)
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com> <Pine.GSO.4.21.0105190940310.5339-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.21.0105190940310.5339-100000@weyl.math.psu.edu>; from Alexander Viro on Sat, May 19, 2001 at 09:57:46AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A lot of stuff relies on the fact that close(open(foo, O_RDONLY)) is a
> no-op. Breaking that assumption is a Bad Thing(tm).

Then we have a problem. Just opening /dev/ttyS0 currently *has* side
effects (it is visible on modem lines from serial port; it can block
you forever). 

If this assumption is somewhere, we should fix that place... Or fix
serial ports.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
