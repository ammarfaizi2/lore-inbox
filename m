Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbSI2TWX>; Sun, 29 Sep 2002 15:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261741AbSI2TWX>; Sun, 29 Sep 2002 15:22:23 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:47022 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261740AbSI2TWX>; Sun, 29 Sep 2002 15:22:23 -0400
Date: Sun, 29 Sep 2002 21:27:46 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH *, testers wanted] remove 614 includes of linux/sched.h
Message-ID: <Pine.LNX.4.33.0209292107510.7666-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to ongoing header file cleanups, many files including linux/sched.h
don't need to do so anymore. A patch for 2.5.39 to remove some 600 
occurences of
  #include <linux/sched.h>
and (hopefully) fix up resulting breakage because of indirect dependencies
can be found at

  http://www.physik3.uni-rostock.de/tim/kernel/2.5/sched.h-16.patch.gz

Extensive analysis using ctags and grep has been done, but surely cannot 
detect all problems.
So I'd be happy if people compile-tested this for different archs and 
configurations and reported problems as well as success to me.

After obtaining sufficient feedback I'll split up the patch and pass it 
through maintainers, which however needs to be a three-stage process 
due to inherent dependencies.

Tim

