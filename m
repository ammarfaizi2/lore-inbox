Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVBBGiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVBBGiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 01:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVBBGiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 01:38:15 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40462 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262127AbVBBGhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 01:37:48 -0500
Date: Wed, 2 Feb 2005 07:38:46 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA HELP: Crackling and popping noises with via82xx
Message-ID: <20050202063846.GA7129@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <9871ee5f05020118343effed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9871ee5f05020118343effed7@mail.gmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 09:34:59PM -0500, Timothy Miller wrote:
> Basically, I get random poppling and crackling noises out of my
> speakers.  Sometimes it's silent, and sometimes, it crackles and pops
> for minutes at a time.  It's really disturbing, really, because it
> happens suddenly, sometimes very loudly, and usually when I'm
> concentrating.  :)

 Try to play with sound card's latency timer using setpci. For me,
that's the only way to silent unwanted pops on ens1370. It may work
with via, too.

 Magic command is: /sbin/setpci -v -s 01:09.0 latency_timer=40
You have to substitute 01:09.0 with your card's PCI location and play
around with latency_time value.

-- 
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray

