Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbUJaOVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUJaOVy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 09:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUJaOVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 09:21:54 -0500
Received: from quechua.inka.de ([193.197.184.2]:45790 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261629AbUJaOVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:21:47 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: LVM Oops
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20041031091355.GA27407@lina.inka.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1COGaW-0001Sq-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 31 Oct 2004 15:21:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041031091355.GA27407@lina.inka.de> you wrote:
> It was some 2.4 version, but the stacktrace was not related to XFS I think.
> It was just that reproducible one got panic or oops (not sure) if the
> snapshot volumne was full. Hevent tried that with 2.6 yet, will do.

Ok, I just retested with 2.6.8.1 and lvm2 on 2 sd disks, I no longer get oops  when
the snapshot fills up. (However I cant control a policy what should happen
on snapshot fillup. Currently it looks like dm-snap is always invalidating
the snapshot LV. Other option would be to block IO (on the original drive)
or return ENOSPC. I can think of situations where this is desired.

My inital problems howwever have been with lvm1 meta data volumnes and 2.4,
cant test those anymore.

Greetings
Bernd
