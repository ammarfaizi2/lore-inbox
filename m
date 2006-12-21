Return-Path: <linux-kernel-owner+w=401wt.eu-S1423071AbWLUURH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423071AbWLUURH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423064AbWLUURG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:17:06 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:42931 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423071AbWLUURE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:17:04 -0500
Date: Thu, 21 Dec 2006 21:09:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Albert Cahalan <acahalan@gmail.com>
cc: kzak@redhat.com, hvogel@suse.de, olh@suse.de, hpa@zytor.com,
       linux-kernel@vger.kernel.org, arekm@maven.pl,
       util-linux-ng@vger.kernel.org
Subject: Re: util-linux: orphan
In-Reply-To: <787b0d920612200927u61e08288o1728ff6433bd92b@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0612212106560.10411@yvahk01.tjqt.qr>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> 
 <Pine.LNX.4.61.0612201712190.15218@yvahk01.tjqt.qr>
 <787b0d920612200927u61e08288o1728ff6433bd92b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> What about merging util-linux and procps?
>
> How? Which way?

In that all the following tools (and possibly files) which are
returned by `rpm ql procps` replace the util-linux counterparts, if
any. Note that rpm -ql might return less programs than actually
present in procps, since distributors need to choose which program to
pick from what {util-linux or procps}.

21:07 ichi:~ > rpm -ql procps
/bin/ps
/etc/init.d/boot.sysctl
/etc/sysctl.conf
/etc/xinetd.d/systat
/sbin/sysctl
/usr/bin/free
/usr/bin/pgrep
/usr/bin/pkill
/usr/bin/pmap
/usr/bin/pwdx
/usr/bin/skill
/usr/bin/slabtop
/usr/bin/snice
/usr/bin/tload
/usr/bin/top
/usr/bin/vmstat
/usr/bin/w
/usr/bin/watch
+ the stuff in /usr/share/doc and /usr/share/man

with the idea that you retain maintership over these. So my proposal/idea was
just one of how to package it.

> being bogged down in problems. One by one, the various
> Linux distributions switched over to my version of the code.
>
> So as you may imagine, I'd be rather nervous about letting
> procps get into that situation again. Bugs are yucky. Having
> multiple committers and no testing is a sure path to ruin.

	-`J'
-- 
