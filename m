Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTDNVa3 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTDNVa3 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:30:29 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:50890 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263957AbTDNV3c (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:29:32 -0400
Date: Mon, 14 Apr 2003 23:41:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: James Bourne <jbourne@hardrock.org>
Cc: Martin Schlemmer <azarah@gentoo.org>,
       Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy
Message-ID: <20030414214106.GA22050@wohnheim.fh-wedel.de>
References: <20030414185806.GA12740@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0304141515080.24383-100000@cafe.hardrock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0304141515080.24383-100000@cafe.hardrock.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 April 2003 15:19:27 -0600, James Bourne wrote:
> On Mon, 14 Apr 2003, Jörn Engel wrote:
> 
> > So basically, neither the existing EXTRAVERSION nor my new FIXLEVEL
> > are checked. Any code could potentially break with -ac1 to -ac2 or
> > with .1 to .2.
> > 
> > Did anyone experience such problems with -ac already? There are far
> > more changes in -ac than there are in your patch.
> 
> Which brings the point as to why use a new variable unless you are going to
> actually modify LINUX_VERSION_CODE with it.  It actually makes more sense to
> just use EXTRAVERSION for this then.
> 
> Now, using EXTRAVERSION = .2 wouldn't be unrealistic...

Good point. My two (weak) arguments for the new variable are:

- A fixes-only tree is imo different from any other patchset and
should be marked as such. 2.4.20.2 sounds more official than
2.4.20-jb2. Whether this should be underscored for the developers as
well - not sure.

- It makes things like 2.4.20.1-je1 easier. But then again, someone
will come up with 2.4.21-pre7-ac1-je2-something_else5-even_more.

Sound a little too weak for the extra variable. Could have been a sign
that I lost the patch.

Jörn

-- 
Anything that can go wrong, will.
-- Finagle's Law
