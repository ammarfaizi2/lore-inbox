Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTGCMds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTGCMds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:33:48 -0400
Received: from pasta.sw.starentnetworks.com ([12.33.234.10]:6375 "EHLO
	pasta.sw.starentnetworks.com") by vger.kernel.org with ESMTP
	id S261245AbTGCMdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:33:47 -0400
Date: Thu, 3 Jul 2003 08:48:13 -0400
From: Brian Ristuccia <bristucc@sw.starentnetworks.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rmap15j: sometimes processes stuck in state D, WCHAN 'down'
Message-ID: <20030703124813.GN24907@sw.starentnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been seeing processes which occasionally get stuck in state D, WCHAN
'down'. If I go look in /proc/pid/fd, or proc/pid/cwd/, usually I can find
one of the open files or directory which will I can hang a new process by
attempting to access. The affected files/directories have been on a local
ext3 filesystem. The stuck processes are unkillable, even with signal 9.

If I attempt to attach to one of the hung processes with strace, there is no
output from strace, and the strace process becomes hung and unkillable as
well.

Is anyone else seeing this problem with stock 2.4.21 or 2.4.21-rmap15j?

--
Brian Ristuccia
bristucc@sw.starentnetworks.com
