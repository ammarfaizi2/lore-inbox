Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284034AbRLKVUS>; Tue, 11 Dec 2001 16:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284037AbRLKVUI>; Tue, 11 Dec 2001 16:20:08 -0500
Received: from zok.sgi.com ([204.94.215.101]:57250 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S283488AbRLKVUA>;
	Tue, 11 Dec 2001 16:20:00 -0500
Subject: Re: possible bug with RAID
From: Steve Lord <lord@sgi.com>
To: Steve Lord <lord@sgi.com>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <1008099243.17996.13.camel@jen.americas.sgi.com>
In-Reply-To: <Pine.LNX.4.30.0112111952430.1232-100000@mustard.heime.net> 
	<1008099243.17996.13.camel@jen.americas.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 11 Dec 2001 15:18:31 -0600
Message-Id: <1008105511.17925.0.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-11 at 13:34, Steve Lord wrote:
> On Tue, 2001-12-11 at 12:54, Roy Sigurd Karlsbakk wrote:
> > > it would be interesting to write a simple benchmark
> > > that simply reads a file at a fixed rate.  *that* would
> > > actually simulate your app.
> > 
> > sure. I'm using tux+wget for that. I were just playing around with dd
> > 
> > > sounds like a VM/balance problem.  you didn't mention which kernel
> > > you're using.
> > 
> > 2.4.16 w/tux + xfs. The fs used on the raid vol is xfs
> 
> We just got to the bottom of a problem in xfs which was causing memory
> not to get cleaned as efficiently as it should be - it lead to dbench
> lockups on low memory systems. It is possible you are seeing a similar
> effect - we dirty all the memory and then struggle to clean it up.
> 
> Try the attached patch.
> 
> Steve
> 

OK, don't try that patch too hard, I have a better one without a race
condition on the buffer head.... it should show up in the xfs cvs tree
later today, I am going to stress this one a little harder first!

Steve


