Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272313AbTHDXnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272315AbTHDXnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:43:08 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:58325 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272313AbTHDXnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:43:05 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 01:42:44 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: beepy@netapp.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030805014244.0a71f6c9.skraw@ithnet.com>
In-Reply-To: <03080416295003.04444@tabby>
References: <20030804134415.GA4454@win.tue.nl>
	<200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com>
	<20030804175609.7301d075.skraw@ithnet.com>
	<03080416295003.04444@tabby>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 16:29:50 -0500
Jesse Pollard <jesse@cats-chateau.net> wrote:

> On Monday 04 August 2003 10:56, Stephan von Krawczynski wrote:
> > On Mon, 4 Aug 2003 08:42:09 -0700 (PDT)
> >
> > Brian Pawlowski <beepy@netapp.com> wrote:
> > > I'm still waking up, but '..' obviously breaks the "no cycle"
> > > observations.
> >
> > Hear, hear ...
> >
> > > It's just that '..' is well known name by utilities as opposed
> > > to arbitrary links.
> >
> > Well, that leads only to the point that ".." implementation is just lousy
> > and it should have been done right in the first place. If there is a need
> > for a loop or a hardlink (like "..") all you have to have is a standard way
> > to find out, be it flags or the like, whatever. But taking the filename or
> > anything not applicable to other cases as matching factor was obviously
> > short-sighted.
> 
> Has nothing to do with the loop. It is called an AVL tree.

Hm, ".." points back to a directory in its parent path (in fact simply its own
parent). You don't call this a loop? How come?

If I write a simple program that follows all directory entries of a given
directory it will simply loop, it only won't loop if I tell it explicitely
_not_ to follow ".." and ".", because "." is nothing else but the shortest
possible loop.

Regards,
Stephan
