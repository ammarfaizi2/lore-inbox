Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSHIVsm>; Fri, 9 Aug 2002 17:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSHIVsm>; Fri, 9 Aug 2002 17:48:42 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:42719 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316187AbSHIVsl>; Fri, 9 Aug 2002 17:48:41 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hubertus Franke <frankeh@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       andrea@suse.de, Dave Jones <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0208091441270.29869-100000@torvalds-p95.transmeta.com>
References: <Pine.LNX.4.31.0208091441270.29869-100000@torvalds-p95.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2002 16:46:36 -0500
Message-Id: <1028929600.19435.373.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 16:42, Linus Torvalds wrote:

> Hmm.. Giving them a quick glance-over, the /proc issues look like they
> shouldn't be there in 2.5.x anyway, since the inode number really is
> largely just a random number in 2.5 and all the real information is
> squirelled away at path open time.
> 
> There's certainly a possibility for some cleanups, though.
So for now then, should I dig out my original (minimal) patch that
*just* fixed the "loop forever even if we're out of pids" problem?  Even
if we increase PID_MAX to something obscenely high, I think we should
still be checking for this.

-Paul Larson

