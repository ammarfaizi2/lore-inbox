Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263370AbSJIAet>; Tue, 8 Oct 2002 20:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbSJIAet>; Tue, 8 Oct 2002 20:34:49 -0400
Received: from gw.openss7.com ([142.179.199.224]:9488 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S263370AbSJIAes>;
	Tue, 8 Oct 2002 20:34:48 -0400
Date: Tue, 8 Oct 2002 18:40:29 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: export of sys_call_table
Message-ID: <20021008184029.B17517@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20021004131547.B2369@openss7.org> <20021004.152116.116611188.davem@redhat.com> <20021004164151.D2962@openss7.org> <20021004.153804.94857396.davem@redhat.com> <mailman.1034119380.19047.linux-kernel2news@redhat.com> <200210090030.g990UTe08202@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210090030.g990UTe08202@devserv.devel.redhat.com>; from zaitcev@redhat.com on Tue, Oct 08, 2002 at 08:30:29PM -0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete,

Sorry, wrong patch.  See correct patch re-posted on this thread.

BTW no other symbols in ksyms are exported with EXPORT_SYMBOL_GPL
in 2.4.19.

--brian

On Tue, 08 Oct 2002, Pete Zaitcev wrote:

> > Following is a tested patch for i386 architecture for registration
> > of putpmsg and getpmsg system calls.  This version (courtesy of
> > Dave Grothe at GCOM) uses up/down semaphore instead of read/write
> > spinlocks.  The patch is against 2.4.19 but should apply up and
> > down a ways as well.
> 
> > +EXPORT_SYMBOL(register_streams_calls);
> > +EXPORT_SYMBOL(unregister_streams_calls);
> 
> EXPORT_SYMBOL_GPL perhaps? Otherwise it's just a disguised hook,
> just like nVidia's shell driver.
>  
> > +static rwlock_t streams_call_lock = RW_LOCK_UNLOCKED;
> 
> Does not look like a semaphore to me...
> 
> -- Pete

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
