Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266853AbUFYTQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266853AbUFYTQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUFYTPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:15:34 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26385 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266847AbUFYTON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:14:13 -0400
Date: Fri, 25 Jun 2004 21:05:33 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
Message-ID: <20040625190533.GI29808@alpha.home.local>
References: <200406251840.46577.mbuesch@freenet.de> <40DC56CB.5040907@kolivas.org> <200406252044.25843.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406252044.25843.mbuesch@freenet.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Jun 25, 2004 at 08:44:22PM +0200, Michael Buesch wrote:
 
> I don't know what the file wchan is good for, but here is
> it's output:
> mb@lfs:/proc/11000> cat wchan
> sys_wait4

I bet the process is waiting for a SIGCHLD from a previously forked
process. Con, would it be possible that under some circumstances,
a process does not receive a SIGCHLD anymore, eg if the child runs
shorter than a full timeslice or something like that ? In autoconf
scripts, there are lots of very short operations that might trigger
such unique cases.

Cheers,
Willy

