Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTDWQkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTDWQkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:40:09 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:33190 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264127AbTDWQkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:40:07 -0400
Date: Wed, 23 Apr 2003 11:52:07 -0500
From: Nathan Straz <nstraz@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: Re: XFS problem in 2.5.67-mm4
Message-ID: <20030423165207.GA31190@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <20030421074450.GA13292@thebox.bloog.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421074450.GA13292@thebox.bloog.ddts.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 05:44:50PM +1000, Rob Weir wrote:
> I just decided to jump into 2.5 with 2.5.67-mm4, and I was mightily
> impressed, especially with the interactive 'feel' of it.  Well, mostly,
> since something went wrong with XFS on my /home:
> 
> Apr 21 03:28:01 thebox kernel: 0x0: 4c f9 63 b9 f2 c7 0a e5 8f 7b b9 7d 1b 56 2a 7f 
> Apr 21 03:28:01 thebox kernel: Filesystem "ide0(3,10)": XFS internal error xfs_da_do_buf(2) at line 2248 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01bc657
> Apr 21 03:28:01 thebox kernel: Call Trace: [<c01bc234>]  [<c01bc657>]  [<c01bc657>]  [<c01bc657>]  [<c01c328f>]  [<c01c328f>]  [<c01bf3c0>]  [<c01bf3c0>]  [<c01beb58>]  [<c01bf3c0>]  [<c01f3fd5>]  [<c01fb92b>]  [<c015f80c>]  [<c015fb30>]  [<c015fcea>]  [<c015fb30>]  [<c01092db>] 
[ trace output chopped ]
> Apr 21 04:00:09 thebox kernel: xfs_force_shutdown(ide0(3,10),0x8) called from line 1052 of file fs/xfs/xfs_trans.c.  Return address = 0xc020392b
> Apr 21 04:00:09 thebox kernel: Filesystem "ide0(3,10)": Corruption of in-memory data detected.  Shutting down filesystem: ide0(3,10)
> Apr 21 04:00:09 thebox kernel: Please umount the filesystem, and rectify the problem(s)
> 
> Followed by a whole lot of userspace errors as things failed to write to
> /home.  It is possible I have flakey RAM (I've had some stability
> problems, but memtest86 never seems to be able to find it...), but I
> thought it's better to let you know than not.  If there's any more
> information I can provide, just ask.  Also, I'm on lkml, so no need for
> CC's.

Well, the first thing you might want to do with decode some of those
addresses.  You can have them auto-decoded by enabling CONFIG_KALLSYMS.
Next you might want to send the output of xfs_check.  Can you mount the
file system still?
-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
