Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUJORSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUJORSW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUJORPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:15:48 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:44530 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S268200AbUJORMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:12:10 -0400
Date: Fri, 15 Oct 2004 13:06:48 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: janitoring printk with no KERN_ constants, kill all
  defaults?
To: Dave Jones <davej@redhat.com>
Cc: Daniele Pizzoni <auouo@tin.it>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410151311_MC3-1-8C48-9C05@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> Consider this..
>
>       printk (KERN_INFO "blah blah ");
>       if (foo)
>               printk ("%s", stringptr);
>       else
>               printk ("%d", number);
>       printk ("\n");
>
> There's nothing wrong with any of those printk's, so you
> cannot do the checks you mention above.

  But other code can call printk in between on SMP and/or preempt systems,
making a mess of the log.  This is a(n old) problem that should be
fixed once and for all, AFAIC.



--Chuck Ebbert  15-Oct-04  13:05:20
