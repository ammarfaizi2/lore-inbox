Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbVKXCNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVKXCNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 21:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVKXCNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 21:13:04 -0500
Received: from xenotime.net ([66.160.160.81]:61084 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932614AbVKXCNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 21:13:01 -0500
Date: Wed, 23 Nov 2005 18:13:32 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, kaber@trash.net, bunk@stusta.de, evil@g-house.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: [2.6 patch] do not select NET_CLS
Message-Id: <20051123181332.0f86bfdb.rdunlap@xenotime.net>
In-Reply-To: <20051123055735.GC7579@mars.ravnborg.org>
References: <4381F2D2.5000605@trash.net>
	<20051122.143713.101129339.davem@davemloft.net>
	<20051122224914.GA17575@mars.ravnborg.org>
	<20051122.150041.90521592.davem@davemloft.net>
	<20051123055735.GC7579@mars.ravnborg.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005 06:57:35 +0100 Sam Ravnborg wrote:

> On Tue, Nov 22, 2005 at 03:00:41PM -0800, David S. Miller wrote:
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Tue, 22 Nov 2005 23:49:14 +0100
> > 
> > > On Tue, Nov 22, 2005 at 02:37:13PM -0800, David S. Miller wrote:
> > > > 
> > > > One thing we can do to prevent human
> > > > mistakes, is to make the "make modules" pass do a quick "is vmlinux
> > > > uptodate?" check, and if not print out an error message explaining the
> > > > situation and aborting the "make modules" attempt.
> > > 
> > > I do not quite follow you here.
> > 
> > If the user tries to do a "make modules" without first rebuilding
> > their kernel image, then the make will fail if the dependencies
> > are not satisfied for the main kernel image and it is thus not
> > up to date.
> 
> OK - so a simple 'make -q vmlinux' check, except that the way we utilise
> make will let it fail at first build command.
> That will obscufate things even more in kbuild - but I will give it a
> try sometime. It will be easy to cover 95% but to reach 100%
> predictability will be though.
> - file dependencies is easy
> - command line changes is relatively easy
> - but the various scripts and user commands will be tricky..
> 
> Not on the top of the TODO list though.

So -q means "quick" ?

I wouldn't mind seeing a -quiet (even less quiet than V=0),
not even printing the CC, AS, LD, etc. commands -- just let the
tools print errors & warnings.  I always redirect output to a
disk file and filter it for errors and warnings anyway, so I
want hold my breath for this, but ISTM that V=0 could be even
quieter than it is right now.

---
~Randy
