Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbUCCOzm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 09:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbUCCOzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 09:55:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47030 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262461AbUCCOzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 09:55:15 -0500
Date: Wed, 3 Mar 2004 15:55:14 +0100
From: Jan Kara <jack@suse.cz>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: file locking BUG
Message-ID: <20040303145514.GC8372@atrey.karlin.mff.cuni.cz>
References: <20040227143702.GC15205@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227143702.GC15205@bytesex.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello!

> Got a BUG today.  Happened while playing with user-mode-linux, which
> uses locks for the image files presenting the virtual hard disks.
> 
> The UML kernel complained that it can't lock the disk:
> 
>   F_SETLK failed, file already locked by pid 24612
>   Failed to lock '/work/uml/yast2/harddisk.img', err = 11
> 
> There is no process (any more) with pid 24612 through.  Checked the
> kernel log on the host and found the BUG message below ...
  I was also hitting the bug - host kernel 2.4.23-skas3. It was almost
100% reproducible by running uml under GDB and after it boots let GDB
kill it. I didn't see any Ooops in my case.

								Honza
