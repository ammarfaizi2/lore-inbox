Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271754AbTHDOuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271755AbTHDOuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:50:08 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:48317 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271754AbTHDOuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:50:04 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 16:50:02 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030804165002.791aae3d.skraw@ithnet.com>
In-Reply-To: <Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<20030804134415.GA4454@win.tue.nl>
	<20030804155604.2cdb96e7.skraw@ithnet.com>
	<Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 15:04:28 +0100 (BST)
Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> For a start the kernel VFS dcache would break because you end up with
> multiple entries for each inode, one entry for each parallel directory
> tree.  Read-only you are just about able to get away with it (been there,
> done that, don't recommend it!) but allow files to be deleted and it will
> blow up in your face.

I cannot comment, I have no inside knowledge of it.

> You ask for examples of applications?  There are millions!  Anything that
> walks the directory tree for a start, e.g. ls -R, find, locatedb, medusa,
> du, any type of search and/or indexing engine, chown -R, cp -R, scp
> -R, chmod -R, etc...

There is a flaw in this argument. If I am told that mount --bind does just
about what I want to have as a feature then these applictions must have the
same problems already (if I mount braindead). So an implementation in fs cannot
do any _additional_ damage to these applications, or not?

My saying is not "I want to have hardlinks for creating a big mess of loops
inside my filesystems". Your view simply drops the fact that there are more
possibilities to create and use hardlinks without any loops...

Regards,
Stephan
