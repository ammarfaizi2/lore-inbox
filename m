Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263718AbUD0Dd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbUD0Dd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 23:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbUD0Dd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 23:33:59 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:18566 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263718AbUD0Dd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 23:33:57 -0400
Subject: Re: HELP ipt_hook: happy cracking message
From: Rusty Russell <rusty@rustcorp.com.au>
To: Parag Nemade <cranium2003@yahoo.com>
Cc: kernerl mail <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org,
       netfilter <netfilter-devel@lists.netfilter.org>
In-Reply-To: <20040426151220.85059.qmail@web41403.mail.yahoo.com>
References: <20040426151220.85059.qmail@web41403.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1083036797.2150.14.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Apr 2004 13:33:17 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 01:12, Parag Nemade wrote:
> hi,
>         i modified kernel so that it will create
> /proc/net/myproc file entry.
> the function of this entry is to crate a 16 byte char
> string from random no.s
> i used net_srandom and net_random and sys_time for
> that puspose. the problem is that i write program to
> generate string after 120 seconds but it is changing
> contents of myproc file every seconds. what can i do?
>  Also i am getting ipt_hook: happy cracking. message
> again and again why?

You're sending out IP packets which don't even contain the IP header,
and you're running connection tracking or some filtering.

The message is not serious.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

