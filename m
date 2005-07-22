Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVGVUJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVGVUJY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVGVUJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:09:21 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:23115 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262149AbVGVUIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:08:46 -0400
Date: Fri, 22 Jul 2005 13:08:32 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: njw@osdl.org, Tejun Heo <htejun@gmail.com>
Subject: [announce] 'patchview' ver. 004
Message-Id: <20050722130832.6c22f430.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

[version 004]

'patchview' merges a patch file and a source tree to a set of
temporary modified files.  This enables better patch (re)viewing
and more viewable context.  (hopefully)


The patchview script is here:
  http://www.xenotime.net/linux/scripts/patchview


usage: patchview [-f] [-s] patchfile srctree {ver. 004}
  -f : force tkdiff even if 'patch' has errors
  -s : single tkdiff even if patchfile contains multiple files


It uses (requires) lsdiff (from patchutils) and
tkdiff or mtkdiff (multi-file tkdiff viewer).
'mtkdiff' is used if it is found and is executable.
(and it's pretty cool)


patchutils:  http://cyberelk.net/tim/patchutils/
tkdiff:      http://sourceforge.net/projects/tkdiff/
mtkdiff:     http://home-tj.org/mtkdiff/files/

---
~Randy

Thanks to Nick Wilson and Tejun Heo for patches.

Changes for ver. 004:
* Make sure things get cleaned up if we ctrl-c the sucker.
* Kill the viewers when the script is killed.
* Un-hardcode PROG.
* Add [-s] to usage message.
* Add support for the mtkdiff viewer.
