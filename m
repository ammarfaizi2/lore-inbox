Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWGDJZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWGDJZR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWGDJZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:25:17 -0400
Received: from main.gmane.org ([80.91.229.2]:52378 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751245AbWGDJZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:25:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Benny Amorsen <benny+usenet@amorsen.dk>
Subject: Re: ext4 features
Date: 04 Jul 2006 11:14:27 +0200
Message-ID: <m3r711u3yk.fsf@ursa.amorsen.dk>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: kbhn-vbrg-sr0-vl209-213-185-8-10.perspektivbredband.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "DC" == Diego Calleja <diegocg@gmail.com> writes:

DC> El Mon, 03 Jul 2006 15:46:55 -0600, "Jeff V. Merkey"
DC> <jmerkey@wolfmountaingroup.com> escribió:

>> Add a salvagable file system to ext4, i.e. when a file is deleted,
>> you just rename it and move it to a directory called DELETED.SAV
>> and recycle the files as people allocate new ones. Easy to do
>> (internal "mv" of


DC> Easily doable in userspace, why bother with kernel programming

In userspace you can't automatically delete the files when the space
becomes needed. The LD_PRELOAD/glibc methods also have the
disadvantage of having to figure out where a file goes when it's
deleted, depending on which device it happens to reside on. Demanding
read access to /proc/mounts just to do rm could cause problems.

Userspace has had 10 years to invent a good solution. If it was so
easy, it would probably have been done.


/Benny


