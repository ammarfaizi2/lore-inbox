Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTJTCYt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 22:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbTJTCYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 22:24:49 -0400
Received: from 87.Red-81-38-202.pooles.rima-tde.net ([81.38.202.87]:48426 "EHLO
	falafell.ghetto") by vger.kernel.org with ESMTP id S261685AbTJTCYs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 22:24:48 -0400
Date: Mon, 20 Oct 2003 04:24:43 +0200
From: Pedro Larroy <piotr@member.fsf.org>
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] D-states in test8
Message-ID: <20031020022443.GA1723@81.38.200.176>
Reply-To: piotr@member.fsf.org
References: <20031019205630.GA1153@81.38.200.176> <20031019160127.191a189a.akpm@osdl.org> <20031020012914.GA1315@81.38.200.176> <20031019183610.4410757b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019183610.4410757b.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 06:36:10PM -0700, Andrew Morton wrote:
> Pedro Larroy <piotr@member.fsf.org> wrote:
> >
> > On Sun, Oct 19, 2003 at 04:01:27PM -0700, Andrew Morton wrote:
> > > Pedro Larroy <piotr@member.fsf.org> wrote:
> > > >
> > > > Process just started to get into D state, all subsequent ps got into D.
> > > >  The first that got into D state was mplayer.
> > > 
> > > This might help.
> > > 
> > > --- 25/sound/core/pcm_native.c~pcm_native-deadlock-fix	2003-10-19 15:58:31.000000000 -0700
> > 
> > 
> > Thanks. Also thanks to wli for the insight.
> > 
> 
> Well.  The emphasis is on "might".  That locking bug was on an error path
> and it's quite possible that the deadlock is due to a different bug which
> is still there.
> 

Now seems I can't get them stuck.

Hmm, Before I just opened twice /dev/dsp IIRC and then both processes got 
stuck in D.

so snd_pcm_open_file must have returned < 0

I can try to play a little with it tomorrow to see why gets into the error 
path.
-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
