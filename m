Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272148AbTHDWN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272271AbTHDWN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:13:57 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:49618 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272148AbTHDWN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:13:56 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 00:13:53 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805001353.6e6bbe92.skraw@ithnet.com>
In-Reply-To: <03080416092800.04444@tabby>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<03080409334500.03650@tabby>
	<20030804170506.11426617.skraw@ithnet.com>
	<03080416092800.04444@tabby>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 16:09:28 -0500
Jesse Pollard <jesse@cats-chateau.net> wrote:

> > > It was also done in one of the "popular" code management systems under
> > > unix. (it allowed a "mount" of the system root to be under the CVS
> > > repository to detect unauthorized modifications...). Unfortunately,
> > > the system could not be backed up anymore. 1. A dump of the CVS
> > > filesystem turned into a dump of the entire system... 2. You could not
> > > restore the backups... The dumps failed (bru at the time) because the
> > > pathnames got too long, the restore failed since it ran out of disk space
> > > due to the multiple copies of the tree being created.
> >
> > And they never heard of "--exclude" in tar, did they?
> 
> Doesn't work. Remember - you have to --exclude EVERY possible loop. And 
> unless you know ahead of time, you can't exclude it. The only way we found
> to reliably do the backup was to dismount the CVS.

I don't know the system, so I can only judge from your description:
if they allow mount of something insive the cvs tree, then you have a
mountpoint and can --exclude=mountpoint. You don't run into the system root and
are fine, right? If you don't have known fixed mountpoints use mount -l to find
out.


Regards,
Stephan
