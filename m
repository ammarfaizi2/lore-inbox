Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVEOLYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVEOLYV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 07:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVEOLYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 07:24:20 -0400
Received: from one.firstfloor.org ([213.235.205.2]:4993 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261608AbVEOLYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 07:24:18 -0400
To: Greg KH <greg@kroah.com>
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       arnd@arndb.de, benh@crashing.org
Subject: Re: [PATCH 7/8] ppc64: SPU file system
References: <200505132117.37461.arnd@arndb.de>
	<200505132129.07603.arnd@arndb.de> <20050514074524.GC20021@kroah.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 15 May 2005 13:24:13 +0200
In-Reply-To: <20050514074524.GC20021@kroah.com> (Greg KH's message of "Sat,
 14 May 2005 00:45:25 -0700")
Message-ID: <m1y8agag0y.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
>
> No, as Ben said, do not do this.  Use write.  And as you are only doing
> 1 type of ioctl, it shouldn't be an issue.  Also it will be faster than
> the ioctl due to lack of BKL usage :)

The problem is that if something is wrong regarding 32bit/64bit
compatibility (I am not saying Arnd will get it wrong, but
for a general rule someone will get it wrong and it has happened, e.g.
in ubsfs) then it is impossible to do any compat emulation
on read/write.

So I would actually prefer ioctl because it is sfer.

-Andi
