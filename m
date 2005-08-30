Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVH3TsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVH3TsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVH3TsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:48:11 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:63157 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932426AbVH3TsJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:48:09 -0400
Subject: Re: 2.6.13-rc7-rt4, fails to build
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050830054852.GA5743@elte.hu>
References: <1125277360.2678.159.camel@cmn37.stanford.edu>
	 <20050829083541.GA21756@elte.hu>
	 <1125334627.7631.21.camel@cmn37.stanford.edu>
	 <20050830054852.GA5743@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1125431276.25823.23.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Aug 2005 12:47:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 22:48, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > On Mon, 2005-08-29 at 01:35, Ingo Molnar wrote:
> > > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > > 
> > > > I'm getting a build error for 2.6.13-rc7-rt4 with PREEMPT_DESKTOP for 
> > > > i386:
> > > 
> > > hm, cannot reproduce this build problem on my current tree - could you 
> > > try 2.6.13-rt1? (and please send the 2.6.13-rt1 .config if it still 
> > > occurs)
> > 
> > I had to redo two chunks (this also happened to me in rc7-rt3):
> 
> hm, what is the problem with these two chunks? (they apply fine here, 
> and the patched file builds fine too.)

Weird. These two lines in your patch (in ide-lib.c):
        printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
        printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
have "dUmMy=" instead of "status=", a freshly unpacked
linux-2.6.13.tar.bz2 tree has "status=" there, unless I'm making some
stupid mistake (could be). 

-- Fernando


