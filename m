Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTJTBgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 21:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbTJTBgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 21:36:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:15854 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262378AbTJTBgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 21:36:17 -0400
Date: Sun, 19 Oct 2003 18:36:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: piotr@member.fsf.org
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] D-states in test8
Message-Id: <20031019183610.4410757b.akpm@osdl.org>
In-Reply-To: <20031020012914.GA1315@81.38.200.176>
References: <20031019205630.GA1153@81.38.200.176>
	<20031019160127.191a189a.akpm@osdl.org>
	<20031020012914.GA1315@81.38.200.176>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Larroy <piotr@member.fsf.org> wrote:
>
> On Sun, Oct 19, 2003 at 04:01:27PM -0700, Andrew Morton wrote:
> > Pedro Larroy <piotr@member.fsf.org> wrote:
> > >
> > > Process just started to get into D state, all subsequent ps got into D.
> > >  The first that got into D state was mplayer.
> > 
> > This might help.
> > 
> > --- 25/sound/core/pcm_native.c~pcm_native-deadlock-fix	2003-10-19 15:58:31.000000000 -0700
> 
> 
> Thanks. Also thanks to wli for the insight.
> 

Well.  The emphasis is on "might".  That locking bug was on an error path
and it's quite possible that the deadlock is due to a different bug which
is still there.

