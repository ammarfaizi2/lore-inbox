Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbULQSgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbULQSgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbULQSgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:36:20 -0500
Received: from almesberger.net ([63.105.73.238]:33287 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262105AbULQSgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:36:15 -0500
Date: Fri, 17 Dec 2004 15:36:02 -0300
From: Werner Almesberger <werner@almesberger.net>
To: linux-kernel@vger.kernel.org
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] prio_tree generalization
Message-ID: <20041217153602.D31842@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set for 2.6.10-rc3-bk10 (*) generalizes the prio_tree
code such that other subsystems than just VMA can use it.

(*) I'm not sure which tree is the most useful base for this.
    Should I use 2.6.10-rc3-mm* instead of -bk* ? (Or is it
    already too late for 2.6.10 anyway ?)

While there are currently no other in-tree users than VMA,
the prio_tree algorithm will be useful for detecting overlapping
disk IO requests, which is a prerequisite for efficient handling
of barriers, which - besides being a good idea in general - in
turn is a prerequisite for useful disk IO priorities.

The three patches that follow are incremental and must be applied
in the order specified.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
