Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWDVUJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWDVUJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWDVUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:09:18 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16584 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751004AbWDVUJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:09:17 -0400
Date: Sat, 22 Apr 2006 15:49:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Ingo Oeser <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org
Subject: Re: Van Jacobson's net channels and real-time
Message-ID: <20060422134956.GC6629@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk> <200604211852.47335.netdev@axxeo.de> <20060422114846.GA6629@wohnheim.fh-wedel.de> <200604221529.59899.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200604221529.59899.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 April 2006 15:29:58 +0200, Ingo Oeser wrote:
> On Saturday, 22. April 2006 13:48, Jörn Engel wrote:
> > Unless I completely misunderstand something, one of the main points of
> > the netchannels if to have *zero* fields written to by both producer
> > and consumer. 
> 
> Hmm, for me the main point was to keep the complete processing
> of a single packet within one CPU/Core where this is a non-issue.

That was another main point, yes.  And the endpoints should be as
little burden on the bottlenecks as possible.  One bottleneck is the
receive interrupt, which shouldn't wait for cachelines from other cpus
too much.

Jörn

-- 
Why do musicians compose symphonies and poets write poems?
They do it because life wouldn't have any meaning for them if they didn't.
That's why I draw cartoons.  It's my life.
-- Charles Shultz
