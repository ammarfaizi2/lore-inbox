Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272289AbTHDXea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272299AbTHDXea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:34:30 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:37077 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272289AbTHDXe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:34:28 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 01:34:25 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: aia21@cam.ac.uk, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805013425.03fb9871.skraw@ithnet.com>
In-Reply-To: <03080416163901.04444@tabby>
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<Pine.SOL.4.56.0308041458500.22102@orange.csi.cam.ac.uk>
	<20030804165002.791aae3d.skraw@ithnet.com>
	<03080416163901.04444@tabby>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 16:16:39 -0500
Jesse Pollard <jesse@cats-chateau.net> wrote:

> > > You ask for examples of applications?  There are millions!  Anything that
> > > walks the directory tree for a start, e.g. ls -R, find, locatedb, medusa,
> > > du, any type of search and/or indexing engine, chown -R, cp -R, scp
> > > -R, chmod -R, etc...
> >
> > There is a flaw in this argument. If I am told that mount --bind does just
> > about what I want to have as a feature then these applictions must have the
> > same problems already (if I mount braindead). So an implementation in fs
> > cannot do any _additional_ damage to these applications, or not?
> 
> Mount -bind only modifies the transient memory storage of a directory. It 
> doesn't change the filesystem. Each bind occupies memory, and on a reboot, 
> the bind is gone.

What kind of an argument is this? What difference can you see between a
transient loop and a permanent loop for the applications? Exactly zero I guess.
In my environments nil boots ought to happen. 
This is the reason why I would in fact be satisfied with mount -bind if only I
could export it via nfs...

> > My saying is not "I want to have hardlinks for creating a big mess of loops
> > inside my filesystems". Your view simply drops the fact that there are more
> > possibilities to create and use hardlinks without any loops...
> 
> been there done that, is is a "big mess of loops".
> 
> And you can't prevent the loops either, without scanning the entire graph, or
> keeping a graph location reference embeded with the file.

Or marking the links as type links somehow.

> Which then breaks "mv" for renaming directories... It would then have to
> scan the entire graph again to locate a possble creation of a loop, and 
> regenerate the graph location for every file.

There should be no difference if only a hardlink is simply marked as such by
any kind of marker you possibly can think of.

Regards,
Stephan
