Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263336AbVCKOgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbVCKOgd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbVCKOgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:36:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53910 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263336AbVCKOg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:36:29 -0500
Date: Fri, 11 Mar 2005 15:36:31 +0100
From: Jan Kara <jack@suse.cz>
To: Santosh Gupta <Santosh.Gupta@AzaireNet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fsck error on flashcard with ext2 filesystem
Message-ID: <20050311143631.GA28606@atrey.karlin.mff.cuni.cz>
References: <C8E1D942CB394746BE5CFEB7D97610E762B8EB@bart.corp.azairenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8E1D942CB394746BE5CFEB7D97610E762B8EB@bart.corp.azairenet.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  just a reminder for the next time - please keep the lines length under 80
characters.

> Detailed Description
> -----------------------------
> I am using Core Linux system on flashcard. Its another minimal linux
> distribution. Root filesystem is cramfs and a rw partition on flash is
> ext2. The system is always shutdown properly and initial fsck upon
> bootup shows no error. But if I delete a file on flash card and run
> fsck, it gives error in fsck. On umount and mounting again (or
> reboot), fsck shows no problem. Issuing "sync" command doesnt make any
> difference.
> Why is the disk not getting updated with filesystem metadata even
> after I wait for so long?
  Hmm, it may be a cache aliasing issue (anyway doing fsck on a mounted
filesystem is asking for a trouble and basically nobody promisses any
result). But you may try doing something like:
  sync; blockdev --flushbufs

before a fsck.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
