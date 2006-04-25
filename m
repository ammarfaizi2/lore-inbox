Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWDYWnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWDYWnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 18:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWDYWnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 18:43:35 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:25537 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932233AbWDYWne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 18:43:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 00:43:02 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200604242355.08111.rjw@sisk.pl> <200604260021.08888.rjw@sisk.pl> <20060425222526.GG6379@elf.ucw.cz>
In-Reply-To: <20060425222526.GG6379@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604260043.03481.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 26 April 2006 00:25, Pavel Machek wrote:
> > > It does apply to all of the LRU pages. This is what I've been doing for years 
> > > now. The only corner case I've come across is XFS. It still wants to write 
> > > data even when there's nothing to do and it's threads are frozen (IIRC - 
> > > haven't looked at it for a while). I got around that by freezing bdevs when 
> > > freezing processes.
> > 
> > This means if we freeze bdevs, we'll be able to save all of the LRU pages,
> > except for the pages mapped by the current task, without copying.  I think we
> > can try to do this, but we'll need a patch to freeze bdevs for this purpose. ;-)
> 
> ...adding more dependencies to how vm/blockdevs work. I'd say current
> code is complex enough...

Well, why don't we see the patch?  If it's too complex, we can just decide not
to use it. :-)

Greetings,
Rafael
