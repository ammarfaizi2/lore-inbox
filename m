Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265047AbUEKWt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbUEKWt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 18:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbUEKWsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 18:48:25 -0400
Received: from florence.buici.com ([206.124.142.26]:44166 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S265025AbUEKWsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 18:48:14 -0400
Date: Tue, 11 May 2004 15:48:11 -0700
From: Marc Singer <elf@buici.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: dsaxena@plexity.net, Andrew Morton <akpm@osdl.org>, wim@iguana.be,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Watchdog timer for Intel IXP4xx CPUs
Message-ID: <20040511224811.GA31900@buici.com>
References: <20040511212235.GA7729@plexity.net> <20040511143352.096bc071.akpm@osdl.org> <20040511215008.GA8063@plexity.net> <40A155AC.5090009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A155AC.5090009@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 06:37:32PM -0400, Jeff Garzik wrote:
> Deepak Saxena wrote:
> >On May 11 2004, at 14:33, Andrew Morton was caught saying:
> >+#ifdef CONFIG_WATCHDOG_NOWAYOUT
> >+static int nowayout = 1;
> >+#else
> >+static int nowayout = 0;
> >+#endif
> >+static int heartbeat = 60;	/* (secs) Default is 1 minute */
> >+static unsigned long wdt_status = 0;	
> >+static unsigned long boot_status = 0;
> 
> Wastes bss(?) space to explicitly zero statics.

BTW, BSS is the stuff that is zeroed automatically.  Explicitly
zeroing a variable is a waste of DATA and requires space in the
executable.
