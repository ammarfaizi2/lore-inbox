Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270494AbTGNCYb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270495AbTGNCYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:24:31 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:7825 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id S270494AbTGNCYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:24:30 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Mon, 14 Jul 2003 04:40:40 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200307112053.55880.kernel@kolivas.org> <200307132203.55414.phillips@arcor.de> <200307141013.12202.kernel@kolivas.org>
In-Reply-To: <200307141013.12202.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307140440.40361.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 July 2003 02:13, Con Kolivas wrote:
> On Mon, 14 Jul 2003 06:03, Daniel Phillips wrote:
> I'm not looking at creating a true realtime policy of any sort. Mine is
> more a dynamic policy change to an interactive state that is sustained,

That's clear.

> which gives no more capabilities to a normal user process than they can
> currently get on SCHED_NORMAL tasks. Audio will definitely get priority...

If you mean it will get a quick boost when it needs it, the trouble is, audio 
doesn't need that just sometimes, it needs it all the time.  Hence, the 
tweaks you're doing are fundamentally unable to deliver the kind of audio 
reliablity we'd like to become used to.  That's not to denigrate the value of 
your approach: it does seem to produce good effects in terms of interactive 
response, but it's not a cure-all.

> along with any other interactive task, but not in a real time fashion.
> Basically they effectively get a nice -5 unless they do the wrong thing.

Yes, I noticed pretty quickly that if I wanted to get rid of the audio 
glitches by renicing, I had to use nice -5 or lower.

Regards,

Daniel

