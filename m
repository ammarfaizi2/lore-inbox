Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVLDHtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVLDHtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 02:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVLDHtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 02:49:15 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:3486 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751328AbVLDHtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 02:49:15 -0500
Date: Sat, 3 Dec 2005 23:49:00 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Simon.Derr@bull.net
Subject: How do I remove a patch buried in your *-mm series?
Message-Id: <20051203234900.fcaa6caf.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to remove the patch in *-mm:

  1) cpuset-change-marker-for-relative-numbering.patch

Unfortunately, it collides with another couple cpuset patches later in
your stack:

  2) cpuset-memory-pressure-meter.patch, cpuset-memory-pressure-meter-gcc-295-fix.patch

How should I do this so I minimize the amount of cussing you do in my
general direction:

  A. Just ask you to nuke patch (1) above; let you edit the mess.
  B. Ask you to nuke both (1) and (2); leave me to resend a (2) that applies.
  C. Send a reversing patch that applies on top of your current *-mm stack.
  D. Some other plan you would prefer.

I have verified that removing all the patches above applies cleanly and
builds, with just a harmless -74 lines offset on one of the remaining
cpuset patches.

  So I recommend B.

Separately I will send a patch to remove the bit of Documentation/cpusets.txt
that described this feature.

Details for the historical record:
  I either need to go one step forward with it (fix a bug so that
  it zeros the marker_pid of the left behind cpuset when attach_task
  moves a task), or I need to go five steps backward, with a different
  approach.  But I have other stuff to do first, so should avoid
  digging this "change-marker-for-relative-numbering" any deeper
  than it is for now.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
