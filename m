Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbTIYFSG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 01:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTIYFSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 01:18:06 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:55424 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S261518AbTIYFSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 01:18:04 -0400
Date: Thu, 25 Sep 2003 07:18:01 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-testX: very slow directory reading?
Message-ID: <20030925051801.GA1272@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: vega Linux 2.6.0-test5 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've several quite large (~10000 mails) Maildirs, and using mutt as MUA.
Opening such a maildir took some seconds with 2.4.x kernels (while seeing
"Reading ..." message at the bottom with continously increasing number).
However with 2.6.0-test3 and test5 the symptom is: reading the Maildir
("Reading ..." message) takes about the same emount of time as in 2.4. BUT:
after reaching the last message, mutt waits even several MINUTES to show
mail index page! While this, according to top, mutt is in 'D' state, and IO
wait of the system is 100% (and if I try to do anything on other terminal,
it takes a looooooooooooooooooong time). Is it a mutt or kernel related
problem? Since I don't know internals of mutt, I can't know what mutt tries
to do within that time ... Sorry for my mail, if it is not kernel related
problem. I think it is some kernel related problem, since other applications
also take quite long time (compared to 2.4.x) to read large directories. I
don't understand this, because the key feature for me to use 2.6 (with htree
included by default in the kernel, so no patch is needed) is the htree stuff
to speed of handling of large directories ...


It's on ext3 fs with htree feature enabled, there was fsck with -f -D
switches before.

Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          21e9d65a-9e8c-49ef-a839-2a809df11e3a
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal dir_index filetype needs_recovery sparse_super
Default mount options:    (none)
Filesystem state:         clean
Errors behavior:          Remount read-only
Filesystem OS type:       Linux
[...]

Kernel is 2.6.0-test5, but test3 was the same.

-- 
- Gábor (larta'H)
