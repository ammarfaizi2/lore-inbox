Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265588AbUALQ26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUALQ26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:28:58 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:1462 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265588AbUALQ21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:28:27 -0500
Date: Tue, 13 Jan 2004 00:28:32 +0800 (WST)
From: raven@themaw.net
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net>
Message-ID: <Pine.LNX.4.58.0401130025540.6362@raven.themaw.net>
References: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au>
 <40029C19.409@sun.com> <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 raven@themaw.net wrote:

> On Mon, 12 Jan 2004, Mike Waychison wrote:
> 
> > >
> > >Transparency of an autofs filesystem (as I'm calling it) is the situation
> > >where, given a map
> > >
> > >/usr	/man1	server:/usr/man1
> > >	/man2	server:/usr/man2
> > >
> > >where the filesystem /usr contains, say a directory lib, that needs to be
> > >available while also seeing the automounted directories.
> > >
> > >  
> > >
> > I see.  This requires direct mount triggers to do properly.  Trying to 
> > do it with some sort of passthrough to the underlying filesystem is a 
> > nightmare waiting to happen..
> > 
> 
> So what are we saying here?
> 
> We install triggers at /usr/man1 and /usr/man2.
> Then suppose the map had a nobrowse option.
> Does the trigger also take care of hiding man1 and man2?
> 
> Is there some definition of these triggers?
> 

And I have another question concerning namespaces.

Given that there may be several namespaces, each of which may or may not 
have a trigger on this dentry, is there some sort of list of triggers?

How do the triggers know who owns them?

Ian

