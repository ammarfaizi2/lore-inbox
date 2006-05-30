Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWE3QPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWE3QPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWE3QPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:15:52 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:8598 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751548AbWE3QPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:15:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=GoLYc8WNCHN+q1LZoWH1HWkLCqzdJd9XyFSFsE1mSGZpex4gZ7TFcJFW/2PAli0Ev5GWGFRWbpYi5+vIRjAon30uFs9P0RdmnAs5FVye+JMqIP1rgvjFcplRYt+sZZPut5UIdQC8bGJPvYytbZXBSrO2A3BFdjRWDNXz2+NBEmM=;
Date: Tue, 30 May 2006 20:15:30 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Jiri Slaby <jirislaby@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org, alan@redhat.com
Subject: Re: [patch, -rc5-mm1] lock validator: remove softirq.c WARN_ON
Message-ID: <20060530161530.GA13015@ms2.inr.ac.ru>
References: <20060530022925.8a67b613.akpm@osdl.org> <447C261E.1090202@gmail.com> <20060530115545.GA7025@elte.hu> <20060530160024.GA8987@ms2.inr.ac.ru> <1149005130.3636.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149005130.3636.75.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > static void netlink_table_grab(void)
> > {
> >         write_lock_bh(&nl_table_lock);
> 
> well it could be this one as well...

Indeed.

But it still looks as something very strange.
There are some GFP_KERNEL allocations on the way to this function.
