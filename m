Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVIQP7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVIQP7c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVIQP7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:59:31 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:51721 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751130AbVIQP7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:59:30 -0400
Date: Sat, 17 Sep 2005 11:59:14 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Tony Luck <tony.luck@gmail.com>
Cc: Keith Owens <kaos@sgi.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
Message-ID: <20050917155911.GB19854@tuxdriver.com>
Mail-Followup-To: Tony Luck <tony.luck@gmail.com>,
	Keith Owens <kaos@sgi.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <20050913065937.GA7849@kroah.com> <25288.1126596450@kao2.melbourne.sgi.com> <12c511ca05091708476aa136cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c511ca05091708476aa136cd@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 08:47:03AM -0700, Tony Luck wrote:
> > >So does reverting this patch solve the problem?
> > 
> > I reversing
> > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=064b53dbcc977dbf2753a67c2b8fc1c061d74f21,
> > which appears to be the latest version of this patch.  There was a
> > patch reject in sparc64, but the common code was reverted.  IA64 (SGI
> > Altix) with that patch reverted now boots 2.6.14-rc1.
> 
> Anyone know anything more about this problem?  I'm not seeing it
> on any of my systems ... so perhaps it only affects cards with a
> PCI bridge on them, or cards that haven't already been initialized
> by EFI.

I posted a patch on Wednesday:

	http://www.ussg.iu.edu/hypermail/linux/kernel/0509.1/2193.html

The original reporter (Keith Owens <kaos@sgi.com>) confirmed this
patch to fix the problem.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
