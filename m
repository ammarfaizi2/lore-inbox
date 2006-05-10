Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWEJQmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWEJQmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWEJQmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:42:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46316 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751495AbWEJQmL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:42:11 -0400
Date: Wed, 10 May 2006 17:42:07 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060510164207.GD27946@ftp.linux.org.uk>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com> <1147257266.17886.3.camel@localhost.localdomain> <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net> <1147273787.17886.46.camel@localhost.localdomain> <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net> <1147275571.17886.64.camel@localhost.localdomain> <1147275522.21536.109.camel@c-67-180-134-207.hsd1.ca.comcast.net> <20060510162106.GC27946@ftp.linux.org.uk> <1147279038.21536.120.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147279038.21536.120.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 09:37:18AM -0700, Daniel Walker wrote:
> On Wed, 2006-05-10 at 17:21 +0100, Al Viro wrote:
> 
> > Don't.  Fix.  Correct.  Code.
> > 
> > Ever.  Because sooner or later you will paper over real bug.  It's far better
> > to reject patches that just make $TOOL to STFU than risk blind "fix" hiding
> > a real bug.
> 
> Couldn't agree with you more .. But I don't want to see the warning
> either ..

*shrug*
I hope that raw number of warnings is not used as job performance metrics.
All I can suggest is (a) watch for _changes_ in the warnings between revisions
and (b) get gcc folks fix the warning generation...

> > Unless you show a real codepath that leads to use without initialization
> > (and do that in commit message, so it could be verified as real issue),
> > these patches are worthless in the best case and dangerous in the worst
> > one.
> 
> Several of my patches have nothing to do with initialization .. 

s/codepath.*/bug being fixed/
