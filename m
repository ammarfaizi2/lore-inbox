Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268660AbUGXPCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268660AbUGXPCT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUGXPCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:02:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:60833 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268660AbUGXPCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:02:16 -0400
To: ext2-devel@lists.sourceforge.net, ext3-users@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: ext[23]_rename do not update [cm]time of target directory
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'd like some JUNK FOOD...  and then I want to be ALONE --
Date: Sat, 24 Jul 2004 17:02:12 +0200
Message-ID: <jebri58n4b.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

POSIX says in
<http://www.opengroup.org/onlinepubs/009695399/functions/rename.html>:

  Upon successful completion, rename() shall mark for update the st_ctime
  and st_mtime fields of the parent directory of each file.

ext[23]_rename fail to update st_[cm]time of the target directory if the
target file already existed.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
