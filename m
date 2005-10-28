Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbVJ1UoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbVJ1UoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbVJ1UoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:44:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1681 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751689AbVJ1UoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:44:02 -0400
Date: Fri, 28 Oct 2005 22:43:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: git-send-pack is a nop?
Message-ID: <20051028204344.GA2407@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I replaced

rsync -zavP -essh --delete * $1

with

git-send-pack --all $1

...and now my trees on kernel.org no longer update. I'll switch back
to rsync for now, but if you know what is wrong... Rest of script is:

#!/bin/bash
push() {
    git-send-pack --all $1
#    rsync -zavP -essh --delete * $1
}
cd /usr/src/linux/.git && push pavel@master.kernel.org:/pub/scm/linux/kernel/git/pavel/work.git
cd /usr/src/linux-good/.git && push pavel@master.kernel.org:/pub/scm/linux/kernel/git/pavel/good.git
cd /usr/src/linux-z/.git && push pavel@master.kernel.org:/pub/scm/linux/kernel/git/pavel/zaurus.git
cd /usr/src/linux-sw3/.git && push pavel@master.kernel.org:/pub/scm/linux/kernel/git/pavel/swsusp3.gi\t
cd /data/l/clean-cg; cg-update origin


-- 
Thanks, Sharp!
