Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271750AbTHDOWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271753AbTHDOWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:22:51 -0400
Received: from dsl093-172-017.pit1.dsl.speakeasy.net ([66.93.172.17]:18816
	"EHLO nevyn.them.org") by vger.kernel.org with ESMTP
	id S271750AbTHDOWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:22:48 -0400
Date: Mon, 4 Aug 2003 10:22:45 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: ext3 badness in 2.6.0-test2
Message-ID: <20030804142245.GA1627@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I came back this morning and found:
  EXT3-fs error (device md0) in start_transaction: Journal has aborted
  EXT3-fs error (device md0) in start_transaction: Journal has aborted
  EXT3-fs error (device md0) in start_transaction: Journal has aborted

Unfortunately, from the very first one, all writes failed; including all
writes to syslog.  So I don't know what happened at the beginning.  Is this
more likely to be something internal to ext3, or a problem with the RAID
layer?

The RAID was able to shut down cleanly and came back up with no errors, and
the ext3 filesystem was tagged as having (just a few) errors on next boot,
so I'm guessing an ext3 problem.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
