Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTDWNDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTDWNDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:03:34 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:8157 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264023AbTDWNDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:03:32 -0400
Date: Wed, 23 Apr 2003 09:01:39 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Tony Spinillo <tspinillo@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423130139.GD354@phunnypharm.org>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423125315.GH820@hottah.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 02:53:15PM +0200, Stelian Pop wrote:
> On Wed, Apr 23, 2003 at 05:29:40AM -0700, Tony Spinillo wrote:
> 
> > Stelian
> > 
> > Similiar problem here. Machine boots fine, but when I plug my DV
> > camera in I can't cat /proc/bus/ieee1394/ devices, and I get looping
> > messages in dmesg. If I move the 1394 drivers from pre-7 in, all works
> > fine.
> > (Thanks Dan). I submitted my logs and hw info to:
> > http://sourceforge.net/mailarchive/forum.php?thread_id=2009188&forum_id=5387
> > 
> 
> The following patch seems to cure my problem, I'm not sure yours
> is the same.
> 
> I'm not absolutely sure about the corectness of the patch, but I
> believe that kernel_thread should not be called with interrupts
> disabled.
> 
> I'll leave up to the ieee1394 developpers to decide if some other,
> semaphore based, locking is still necessary here.

The patch is broken, and the problem is already fixed in our repo. Just
a matter of getting Marcelo to accept my patch before 2.4.21 is
released.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
