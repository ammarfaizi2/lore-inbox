Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbVDHUOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVDHUOe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 16:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVDHUOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 16:14:34 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:56553 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262942AbVDHUOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 16:14:31 -0400
X-ORBL: [68.120.153.162]
Date: Fri, 8 Apr 2005 13:14:25 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ragnar Kj?rstad <kernel@ragnark.vestdata.no>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Uncached stat performace [ Was: Re: Kernel SCM saga.. ]
Message-ID: <20050408201425.GB6509@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org> <20050408180540.GA4522@taniwha.stupidest.org> <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org> <20050408191638.GA5792@taniwha.stupidest.org> <Pine.LNX.4.58.0504081232430.28951@ppc970.osdl.org> <20050408201150.GL20644@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408201150.GL20644@vestdata.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 10:11:51PM +0200, Ragnar Kj?rstad wrote:

> It does, so why isn't there a way to do this without the disgusting
> hack? (Your words, not mine :) )

inode sorting probably a good guess for a number of filesystems, you
can map the blocks used to do better still (somewhat fs specific)

you can do better still if you multiple stats in parallel (up to a
point) and let the elevator sort things out

> I bet it would make a significant difference from things like "ls -l" in
> large uncached directories and imap-servers with maildir?

sort + concurrent stats would help here i think

i'm not sure i like the idea of ls using lots of threads though :)
