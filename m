Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUBWDdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 22:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUBWDdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 22:33:25 -0500
Received: from mail.aei.ca ([206.123.6.14]:57042 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261790AbUBWDdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 22:33:24 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Date: Sun, 22 Feb 2004 22:33:20 -0500
User-Agent: KMail/1.5.93
Cc: Mike Fedyk <mfedyk@matchmail.com>
References: <4037FCDA.4060501@matchmail.com> <200402220903.08299.edt@aei.ca> <40396551.9030002@matchmail.com>
In-Reply-To: <40396551.9030002@matchmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402222233.20426.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 22, 2004 09:28 pm, Mike Fedyk wrote:
> Ed Tomlinson wrote:
> > On February 21, 2004 10:28 pm, Linus Torvalds wrote:
> >>On Sat, 21 Feb 2004, Chris Wedgwood wrote:
> >>>Maybe gradual page-cache pressure could shirnk the slab?
> >>
> >>What happened to the experiment of having slab pages on the (in)active
> >>lists and letting them be free'd that way? Didn't somebody already do
> >>that? Ed Tomlinson and Craig Kulesa?
> >
> > You have a good memory.
> >
> > We dropped this experiment since there was a lot of latency between the
> > time a slab page became freeable and when it was actually freed.  The
> > current call back scheme was designed to balance slab preasure and
> > vmscaning.
>
> Does it really matter if there is a lot of latency?  How does this
> affect real-world results?  IOW, if it's not at the end of the LRU, then
> there's probably something better to free instead...

It mattered.  People noticed and complained.  In any case, as Andrew 
pointed out, we get the same effect, without long latencies, in a simplier 
manner with the current scheme.

Ed
