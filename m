Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVC3HcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVC3HcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVC3HcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:32:04 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:20613 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261812AbVC3Hbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:31:45 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [RFD] 'nice' attribute for executable files
To: Wiktor <victorjan@poczta.onet.pl>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 29 Mar 2005 22:45:22 +0200
References: <fa.ed33rit.1e148rh@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor <victorjan@poczta.onet.pl> wrote:

> furthermore, on many systems root may want to make users able to run
> some program with lowered nice, but not from root account and without
> having to know the root password... i've found a way to do this using
> shell scripts combined with suid bit and strange fils ownerships, but it
> is absolute diseaster.

You want su1, or maybe sudo.

> so i thought that it would be nice to add an attribute to file
> (changable only for root) that would modify nice value of process when
> it starts. if there is one byte free in ext2/3 file metadata, maybe it
> could be used for that? i think that it woundn't be more dangerous than
> setuid bit.

Remember: xmms might be configured to spawn the shell plugin.



I guess there should be a maximum renice value ulimit instead, which would
allow running allmost any user task on a higher nice level, except the
important stuff, with the additional benefit of being able to temporarily
renice some tasks until the more important work is done.

I remember something similar being discussed for realtime tasks, but I don't
remember the outcome.
