Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263266AbSJHUVT>; Tue, 8 Oct 2002 16:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJHUUI>; Tue, 8 Oct 2002 16:20:08 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20905 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263245AbSJHUTd>; Tue, 8 Oct 2002 16:19:33 -0400
Date: Tue, 8 Oct 2002 16:25:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: zaitcev@redhat.com, kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: kbuild news
Message-ID: <20021008162504.B4135@devserv.devel.redhat.com>
References: <mailman.1034070360.25457.linux-kernel2news@redhat.com> <200210081442.g98EgeH11258@devserv.devel.redhat.com> <20021008.131100.47229080.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008.131100.47229080.davem@redhat.com>; from davem@redhat.com on Tue, Oct 08, 2002 at 01:11:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 08 Oct 2002 13:11:00 -0700 (PDT)
> From: "David S. Miller" <davem@redhat.com>

>    From: Pete Zaitcev <zaitcev@redhat.com>
>    Date: Tue, 8 Oct 2002 10:42:40 -0400
>    
>    Let's face it, both btfixup and kallsyms "want" to be the last,
>    so something has to give.
> 
> No, btfixup does not care about anything that will go into
> kallsyms.o, no BTFIXUP objects may appear in kallsyms.
> 
> So btfixup may be next to last just fine.

This is very unfortunate, because it invalidates the workaround
where I moved btfixup to "make image" stage. Unles Kai is willing
to change the way the dependencies are handled, I'm stuck.
I am talking about breaking up this:

$(sort $(vmlinux-objs)): $(SUBDIRS) ;

To make every single object (including head.o) on every other
subdirectory (even benign ones) seems a little fishy.

-- Pete
