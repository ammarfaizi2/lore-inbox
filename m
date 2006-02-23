Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWBWWhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWBWWhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWBWWhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:37:34 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:21657 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751797AbWBWWhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:37:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 23 Feb 2006 23:37:30 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602230944.26253.rjw@sisk.pl> <20060223121707.GP13621@elf.ucw.cz>
In-Reply-To: <20060223121707.GP13621@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602232337.31075.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 23 February 2006 13:17, Pavel Machek wrote:
> > > Ok, I have no problems with visions.
> > > 
> > > > I think we should try to get the pagecache stuff right first anyway.
> > > 
> > > Are you sure it is worth doing? I mean... it only helps on small
> > > machines, no?
> > > 
> > > OTOH having it for benchmarks will be nice, and perhaps we could use
> > > that kind it to speed up boot and similar things... 
> > 
> > Currently some people can't suspend with the mainline code because it cannot
> > free as much memory as needed on their boxes.  I think we should care for them
> > too.
> 
> But saving pagecache will not help them *at all*!
> 
> [Because pagecache is freeable, anyway, so it will be freed. Now... I
> have seen some problems where free_some_memory did not free enough,
> and schedule()/retry helped a bit... that probably should be fixed.]

It seems I need to understand correctly what the difference between what
we do and what Nigel does is.  I thought the Nigel's approach was to save
some cache pages to disk first and use the memory occupied by them to
store the image data.  If so, is the page cache involved in that or something
else?

Rafael
