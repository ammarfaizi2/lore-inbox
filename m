Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271405AbTHDPFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271807AbTHDPFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:05:13 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:60094 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271405AbTHDPFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:05:08 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 17:05:06 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030804170506.11426617.skraw@ithnet.com>
In-Reply-To: <03080409334500.03650@tabby>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<20030804134415.GA4454@win.tue.nl>
	<20030804155604.2cdb96e7.skraw@ithnet.com>
	<03080409334500.03650@tabby>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 09:33:44 -0500
Jesse Pollard <jesse@cats-chateau.net> wrote:

> Find for one. Any application that must scan the tree in a search. Any 
> application that must backup every file for another (I know, dump bypasses
> the filesystem to make backups, tar doesn't).

All that can handle symlinks already have the same problem nowadays. Where is
the difference? And yet again: it is no _must_ for the feature to use it for
creating complete loops inside your fs. 
You _can_ as well dd if=/dev/zero of=/dev/hda, but of course you shouldn't.
Have you therefore deleted dd from your bin ?

> It introduces too many unique problems to be easily handled. That is why
> symbolic links actually work. Symbolic links are not hard links, therefore
> they are not processed as part of the tree. and do not cause loops.

tar --dereference loops on symlinks _today_, to name an example.
All you have to do is to provide a way to find out if a directory is a
hardlink, nothing more. And that should be easy.

> It was also done in one of the "popular" code management systems under
> unix. (it allowed a "mount" of the system root to be under the CVS
> repository to detect unauthorized modifications...). Unfortunately,
> the system could not be backed up anymore. 1. A dump of the CVS filesystem
> turned into a dump of the entire system... 2. You could not restore the
> backups... The dumps failed (bru at the time) because the pathnames got
> too long, the restore failed since it ran out of disk space due to the
> multiple copies of the tree being created.

And they never heard of "--exclude" in tar, did they?

> The KIS principle is the key. A graph is NOT simple to maintain.

This is true. But I am very willing to believe reiserfs is not simple either,
still it is there ;-)

Regards,
Stephan
