Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUHZEpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUHZEpD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267542AbUHZEpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:45:03 -0400
Received: from waste.org ([209.173.204.2]:689 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267529AbUHZEoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:44:55 -0400
Date: Wed, 25 Aug 2004 23:44:25 -0500
From: Matt Mackall <mpm@selenic.com>
To: Nicholas Miell <nmiell@gmail.com>
Cc: Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826044425.GL5414@waste.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093480940.2748.35.camel@entropy>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 05:42:21PM -0700, Nicholas Miell wrote:
> On Wed, 2004-08-25 at 16:46, Wichert Akkerman wrote:
> > Previously Jeremy Allison wrote:
> > > Multiple-data-stream files are something we should offer, definately (IMHO).
> > > I don't care how we do it, but I know it's something we need as application
> > > developers.
> > 
> > Aside from samba, is there any other application that has a use for
> > them? 
> > 
> 
> Anything that currently stores a file's metadata in another file really
> wants this right now. Things like image thumbnails, document summaries,
> digital signatures, etc.

That is _highly_ debatable. I would much rather have my cp and grep
and cat and tar and such continue to work than have to rewrite every
tool because we've thrown the file-is-a-stream-of-bytes concept out
the window. Never mind that I've got thumbnails, document summaries,
and digital signatures already.

While the number of annoying properties of files with forks is
practically endless, the biggest has got to be utter lack of
portability. How do you stick the thing in an attachment or on an ftp
site? Well you can't because it's NOT A FILE. 

A file is a stream of bytes.

-- 
Mathematics is the supreme nostalgia of our time.
