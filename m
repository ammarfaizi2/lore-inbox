Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266720AbSKURpd>; Thu, 21 Nov 2002 12:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbSKURpd>; Thu, 21 Nov 2002 12:45:33 -0500
Received: from borg.org ([208.218.135.231]:53689 "HELO borg.org")
	by vger.kernel.org with SMTP id <S266720AbSKURpc>;
	Thu, 21 Nov 2002 12:45:32 -0500
Date: Thu, 21 Nov 2002 12:52:40 -0500
From: Kent Borg <kentborg@borg.org>
To: linux-kernel@vger.kernel.org
Subject: Where is ext2/3 secure delete ("s") attribute?
Message-ID: <20021121125240.K16336@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I happened upon the chattr command and was pleased to see that "s"
means to write zeros (or is it random data?) to the blocks of deleted
files.  Cool, except I can't see that it works.

First, deleting a large file with the "s" attribute happens far too
quickly.

Second, I can't see where any of this is implemented in the source
code (as of Red Hat's 2.4.18-17.7.x and straight 2.4.19).  The file
fs/ext2/CHANGES talks about how the zero writing was changed to
writing random data--but nothing seems to implement this.

What happened to this feature?  Was it too slow or buggy?  Did the
Federales force its removal?

(Would this be best implemented as a background scrub and I am missing
a daemon?)


Thanks,

-kb, the Kent who would like to have his notebook not be full of
easily undeletable files.
