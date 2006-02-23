Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWBWXE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWBWXE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWBWXE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:04:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4262 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751805AbWBWXE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:04:58 -0500
Date: Fri, 24 Feb 2006 00:04:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060223230439.GC1662@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602230944.26253.rjw@sisk.pl> <20060223121707.GP13621@elf.ucw.cz> <200602232337.31075.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602232337.31075.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 23-02-06 23:37:30, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday 23 February 2006 13:17, Pavel Machek wrote:
> > > > Ok, I have no problems with visions.
> > > > 
> > > > > I think we should try to get the pagecache stuff right first anyway.
> > > > 
> > > > Are you sure it is worth doing? I mean... it only helps on small
> > > > machines, no?
> > > > 
> > > > OTOH having it for benchmarks will be nice, and perhaps we could use
> > > > that kind it to speed up boot and similar things... 
> > > 
> > > Currently some people can't suspend with the mainline code because it cannot
> > > free as much memory as needed on their boxes.  I think we should care for them
> > > too.
> > 
> > But saving pagecache will not help them *at all*!
> > 
> > [Because pagecache is freeable, anyway, so it will be freed. Now... I
> > have seen some problems where free_some_memory did not free enough,
> > and schedule()/retry helped a bit... that probably should be fixed.]
> 
> It seems I need to understand correctly what the difference between what
> we do and what Nigel does is.  I thought the Nigel's approach was to save
> some cache pages to disk first and use the memory occupied by them to
> store the image data.  If so, is the page cache involved in that or something
> else?

I believe Nigel only saves pages that could have been freed anyway
during phase1. Nigel, correct me here... suspend2 should work on same
class of machines swsusp can, but will be able to save caches on
machines where swsusp can not save any.
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
