Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbUK3Rk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbUK3Rk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUK3Rk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:40:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44436 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262217AbUK3Rhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:37:34 -0500
Date: Tue, 30 Nov 2004 18:37:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
In-Reply-To: <1101834765l.8903l.4l@werewolf.able.es>
Message-ID: <Pine.LNX.4.53.0411301835511.11795@yvahk01.tjqt.qr>
References: <1101763996l.13519l.0l@werewolf.able.es>
 <Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr> <1101765555l.13519l.1l@werewolf.able.es>
 <20041130071638.GC10450@suse.de> <1101834765l.8903l.4l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I tried scanning with dev=ATAPI, and cdrecord did not found anything.
>Then I tried in my home box, and it found the burner.
>The problem is that in the 'strange' box the burner is hdh, and the
>hard drive for system is hde. The previous IDE channels are unused
>(an on-board promise with ide[01], hd[abcd]).

IMO that should not worry cdrecord where the burner is.

>I use udev, so there is no hd[a-d] nodes on /dev. And cdrecord
>_EXITS_ as soon as it founds a non-existent device !!!

You can find something that does not exist?

>Many things will have to change with udev ;)

I have udev AND like /dev/hdh, even though I don't have an extra IDE
controller. Yay to static entries.
Try mknod'ding hda and so forth (instead of symlinking) and then scanbus the
thing. Does it show up?



Jan Engelhardt
-- 
ENOSPC
