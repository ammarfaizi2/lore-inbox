Return-Path: <linux-kernel-owner+w=401wt.eu-S932162AbXAHVi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbXAHVi4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbXAHVi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:38:56 -0500
Received: from neopsis.com ([213.239.204.14]:51045 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932160AbXAHViz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:38:55 -0500
Message-ID: <45A2BE4C.7030109@dbservice.com>
Date: Mon, 08 Jan 2007 22:57:32 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Thunderbird 2.0b1 (X11/20061212)
MIME-Version: 1.0
To: Dirk <d_i_r_k_@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Gaming Interface
References: <45A22D69.3010905@gmx.net>
In-Reply-To: <45A22D69.3010905@gmx.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Neopsis MailScanner using ClamAV and Spaassassin
X-Neopsis-MailScanner: Found to be clean
X-Neopsis-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.357,
	required 5, autolearn=spam, AWL 0.24, BAYES_00 -2.60)
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk wrote:
> 
> How about having a simple Game API like SDL included in the Kernel and
> officially announce the promise to change it only once every couple of
> years?
> 

A new API would be counter-productive! There's X11/OpenGL for graphics
and OpenAL for sound, both APIs widespread even in the windows world and
also on BSD and all other flavors of UNIX. X11/OpenGL hasn't changed for
years (X11R6 has been released around 1985 IIRC).
The whole point of X11 is that anyone can implement a server, the spec
is open to anyone, and once you write a X11-compliant client it will run
on any UNIX/Linux computer.

Now if you introduce a special API for the Linux kernel, the game
developers would have to create two versions, one for Linux and one for
all other UNIXes. But more realistically, they'd just stick with the
plain old X11/OpenGL/OpenAL design because not everyone will have this
new kernel and they'd still have to release two versions for Linux: one
for the new kernel and one for the older computers.

Linus already stated several times that the kernel ABI is not stable! It
will change, and it's the responsibility of userspace tools/libraries to
provide a stable API.

So, to answer your question: We already have a simple API. One that has
been stable for 10+ years now and won't be changing anytime soon.

tom
