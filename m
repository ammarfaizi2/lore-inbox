Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272305AbTHDWcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272309AbTHDWcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:32:17 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:27091 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272305AbTHDWcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:32:13 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 00:32:10 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805003210.2c7f75f6.skraw@ithnet.com>
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

> > tar --dereference loops on symlinks _today_, to name an example.
> > All you have to do is to provide a way to find out if a directory is a
> > hardlink, nothing more. And that should be easy.
> 
> Yup - because a symlink is NOT a hard link. it is a file.
> 
> If you use hard links then there is no way to determine which is the "proper"
> link.

Where does it say that an fs is not allowed to give you this information in
some way?

> 
> >
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

And if you completely run out of ideas in your wild-mounts-throughout-the-tree
problem you should simply use "tar -l".

And in just the same way fs could provide a mode bit saying "hi, I am a
hardlink", and tar can then easily provide option number 1345 saying "stay away
from hardlinks".

If you can do the fs patch, I can do the tar patch.

Regards,
Stephan


