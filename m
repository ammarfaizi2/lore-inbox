Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTJNPUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 11:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbTJNPUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 11:20:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:39121 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262360AbTJNPUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 11:20:02 -0400
Date: Tue, 14 Oct 2003 08:19:50 -0700
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] Make pmdisk suspend more reliable
Message-ID: <20031014151950.GA11710@atomide.com>
References: <20031012161828.GA1728@atomide.com> <20031012180703.GA2328@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031012180703.GA2328@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
X-Mailer: Mutt http://www.mutt.org/
X-URL: http://www.muru.com/ http://www.atomide.com
X-Accept-Language: fi en
X-Location: USA, California, San Francisco
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Sam Ravnborg <sam@ravnborg.org> [031012 11:07]:
> On Sun, Oct 12, 2003 at 09:18:28AM -0700, Tony Lindgren wrote:
> 
> >  extern int pmdisk_arch_suspend(int resume);
> > +extern int wakeup_bdflush(long nr_pages);
> 
> Prototypes in .c files is never a good idea.
> wakeup_bdflush is prototyped in include/linux/writeback.h

I guess you mean to #include <linux/writeback.h> instead of extern, or
did I misunderstand what you meant?

There may be more to the suspend image not getting to the disk besides
flushing, I'm now wondering if it works with IDE DMA enabled, but not
without DMA. I'll try to investigate it a bit further.

Tony
