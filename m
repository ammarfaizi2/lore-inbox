Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTFKUNC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTFKUNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:13:01 -0400
Received: from ip68-2-19-97.ph.ph.cox.net ([68.2.19.97]:23467 "EHLO
	dent.deepthot.org") by vger.kernel.org with ESMTP id S264262AbTFKUMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:12:51 -0400
Date: Wed, 11 Jun 2003 13:26:33 -0700 (MST)
From: Jay Denebeim <denebeim@deepthot.org>
To: linux-kernel@vger.kernel.org
Subject: Build problems with Linux 2.5
Message-ID: <Pine.LNX.4.44.0306101427260.13724-100000@dent.deepthot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(.70, but I doubt that makes a difference)

Hi guys,

  I've been way out of kernel compiling for a long time, however I just
took a job writing device drivers on Linux so I guess I'll be doing quite
a bit of it again.  I've not built a kernel other than an occasional 'make
rpm' on redhat since the 2.0 days, so be gentle with me.

  The problem I'm having is with the kernel.  My environment is a standard 
Redhat 9 installation:

gcc-3.2.2-5
binutils-2.13.90.0.18-9
modutils-2.4.22-8
kernel-smp-2.4.20-9

  The problem I'm having seems to be related to modutils.  When I make 
very many modules I can't install the system because depmod can't find 
symbols undery 2.4.  However using nm I can see that those symbols are 
indeed defined.  If I make a bare bones system and only have the two or 
three modules I need (I'm working with SCSI device drivers and need to 
unload/reload the modules) the depmod passes, but the modprobe fails with 
QM_MODULES: function unimplemented.

  So, I went grepping through the source code and QM_MODULES exists in 
linux/module.h in 2.4, but not in 2.5.  Since modutils depends on that 
functionality heavily modutils must have been re-written.  However the 
latest version I can find on kernel.org is 2.4.25 and it still uses 
QM_MODULES.  So, where is it?

  Are there other things I'm going to need for 2.5?  I've already figured 
out LVM is totally different, and that breaks mkinitrd if I've got root on 
a logical volume.  Anything else?

  Thanks in advance for your time.

  Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *



