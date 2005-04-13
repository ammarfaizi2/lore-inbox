Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbVDMAzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbVDMAzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 20:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVDMAy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:54:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:55720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262139AbVDMArh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 20:47:37 -0400
Date: Tue, 12 Apr 2005 17:47:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hangcheck-timer: Update to 0.9.0.
Message-Id: <20050412174726.168df393.akpm@osdl.org>
In-Reply-To: <20050413003804.GJ31163@ca-server1.us.oracle.com>
References: <20050412235033.GI31163@ca-server1.us.oracle.com>
	<20050412171801.444df4bc.akpm@osdl.org>
	<20050413003804.GJ31163@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> > Joel Becker <Joel.Becker@oracle.com> wrote:
>  > > +# define TIMER_FREQ 1000000000ULL
>  > > +# define TIMER_FREQ 0xFA240000ULL
>  > > +# define TIMER_FREQ ((unsigned long long)local_cpu_data->itc_freq)
>  > > +# define TIMER_FREQ (HZ*loops_per_jiffy)
>  > 
>  > In the above case specifically, no ifdefs should be needed - you can simply
>  > define CONFIG_HANGCHECK_TIMER_FREQ in arch/*/Kconfig.
> 
>  	Kbuild foo help, please.  I can't quite figure out how to
>  represent the non-constant values as code in Kbuild.   I can represent
>  them as strings, but then they are strings, not code.

Oh, I missed that.  Don't worry about it then.  (It'd be nicer to put the
ifdeffery in a header file tho)

