Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVCaVG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVCaVG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVCaVG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:06:57 -0500
Received: from webmail.topspin.com ([12.162.17.3]:57723 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261936AbVCaVEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:04:52 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org,
       mvw@planets.elm.net
Subject: Re: Stack usage tasks
X-Message-Flag: Warning: May contain useful information
References: <df35dfeb05033023394170d6cc@mail.gmail.com>
	<20050331150548.GC19294@wohnheim.fh-wedel.de>
	<20050331203010.GF3185@stusta.de>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 31 Mar 2005 12:43:38 -0800
In-Reply-To: <20050331203010.GF3185@stusta.de> (Adrian Bunk's message of
 "Thu, 31 Mar 2005 22:30:10 +0200")
Message-ID: <52ll83mtqd.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 Mar 2005 20:43:38.0731 (UTC) FILETIME=[512103B0:01C53632]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > The task I'm suggesting was therefore:
    > - remove the -fno-unit-at-a-time in arch/i386/Makefile in your private
    >   kernel sources
    > - use gcc 3.4
    > - reduce the stack usages in call paths > 3kB

This is a good idea.  However, I might suggest using gcc 4.0 (you'll
have to use a snapshot now, but the release should only be a few weeks
away).  A patch went into gcc 4.0 that makes gcc more intelligent
about sharing stack for variables that cannot be alive at the same
time, and therefore it may be more feasible to make unit-at-a-time
work for the i386 kernels.

 - R.
