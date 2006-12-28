Return-Path: <linux-kernel-owner+w=401wt.eu-S1754991AbWL1VIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbWL1VIG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWL1VIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:08:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54711 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992AbWL1VIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:08:05 -0500
Date: Thu, 28 Dec 2006 21:08:03 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
Message-ID: <20061228210803.GR17561@ftp.linux.org.uk>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de> <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 09:58:17PM +0100, Tim Schmielau wrote:
> On Thu, 28 Dec 2006, Andrew Morton wrote:
> 
> > On Thu, 28 Dec 2006 21:27:40 +0100 (CET)
> > Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> > 
> > > After Al Viro (finally) succeeded in removing the sched.h #include in 
> > > module.h recently, it makes sense again to remove other superfluous 
> > > sched.h includes.
> > 
> > Why are they "superfluous"?  Because those compilation
> > units pick up sched.h indirectly, via other includes?
> > 
> > If so, is that a thing we want to do?
> 
> No, there is nothing at all in these files that needs sched.h. I suppose 
> the includes are left over from times when more unrelated macros lived in 
> sched.h (fortunately much of that cruft got cleand up already).

Uh-huh.  How much of build coverage have you got with it?  Note that
"doesn't use symbols defined in sched.h" != "can remove include of
sched.h", which, in turn, is not the same as "removing it doesn't
cause problems on a couple of configs I've tried on amd64".
