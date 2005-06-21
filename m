Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVFUVA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVFUVA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVFUU61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:58:27 -0400
Received: from hera.kernel.org ([209.128.68.125]:54247 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262330AbVFUUwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:52:25 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: -mm -> 2.6.13 merge status
Date: Tue, 21 Jun 2005 13:52:13 -0700
Organization: Open Source Development Lab
Message-ID: <20050621135213.6af4b543@dxpl.pdx.osdl.net>
References: <20050620235458.5b437274.akpm@osdl.org>
	<42B831B4.9020603@pobox.com>
	<1119368364.3949.236.camel@betsy>
	<Pine.LNX.4.62.0506211222040.21678@graphe.net>
	<1119382685.3949.263.camel@betsy>
	<1119384131.15478.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1119387133 6642 10.8.0.74 (21 Jun 2005 20:52:13 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 21 Jun 2005 20:52:13 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005 14:02:09 -0600
Zan Lynx <zlynx@acm.org> wrote:

> On Tue, 2005-06-21 at 15:38 -0400, Robert Love wrote:
> > On Tue, 2005-06-21 at 12:22 -0700, Christoph Lameter wrote:
> > 
> > > I noticed that select() is not working on real files. Could inotify 
> > > be used to fix select()?
> > 
> > Select the system call?  It should work fine.   ;-)
> > 
> > Who is confused?
> > 
> > 	Robert Love
> 
> Sounds interesting.  tail -f could use it.  Instead of sleep 1, seek to
> current position, read to eof; just select() for read on the file and
> sleep in select() until someone else writes to that file.  
> 
> I've never tried doing that.  It might work, for all I know.
> -- 
> Zan Lynx <zlynx@acm.org>


Posix requires select() of regular files always return true:
	http://www.opengroup.org/onlinepubs/009695399/functions/select.html

	File descriptors associated with regular files shall always select true for ready to read, 
	ready to write, and error conditions.

-- 
Stephen Hemminger	<shemminger@osdl.org>
