Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285379AbRLNOCw>; Fri, 14 Dec 2001 09:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285380AbRLNOCm>; Fri, 14 Dec 2001 09:02:42 -0500
Received: from mustard.heime.net ([194.234.65.222]:22688 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S285379AbRLNOCi>; Fri, 14 Dec 2001 09:02:38 -0500
Date: Fri, 14 Dec 2001 15:02:17 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] RAID sub system
In-Reply-To: <Pine.LNX.4.33.0112131525470.15231-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0112141448020.6153-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> my observation is this: once you use up all your free memory, you have
> 30 seconds of reasonable behavior.  30 seconds is the the default dirty-buffer
> age.  are you tweaking /proc/sys/vm/bdflush at all?  and no, I don't see
> why your application would have dirty buffers in the first place -
> I'm just noticing the ominous 30 seconds.

More testing with bootparam mem=xxx shows this is it. When all memory is
used, it fails to re-use old cache, or something.

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

