Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269390AbUJMQFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269390AbUJMQFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 12:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269730AbUJMQFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 12:05:33 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:62614 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269390AbUJMQF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 12:05:28 -0400
Message-ID: <9625752b04101309054eccbf@mail.gmail.com>
Date: Wed, 13 Oct 2004 09:05:28 -0700
From: Danny <dannydaemonic@gmail.com>
Reply-To: Danny <dannydaemonic@gmail.com>
To: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: mm kernel oops with r8169 & named, PREEMPT
Cc: netdev@oss.sgi.com
In-Reply-To: <20041013072814.GA24066@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9625752b041012230068619e68@mail.gmail.com>
	 <20041013072814.GA24066@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 09:28:14 +0200, Francois Romieu wrote:
> Try the patch below (courtesy of Jon Mason, whitespaces may be wrong) and
> see 1) if things perform better 2) if "timeout" messages appear in the
> kernel log.

The patch doesn't fix or prevent the oops.  Performance might have
been better but I did no formal tests.  There were no "timeout"
messages in the kernel log, however I only ran it with this change for
35-45 minutes.

I should mention that in the kernel log, with linux-2.6.8.1-mm4, it
complains "process `named' is using obsolete setsockopt SO_BSDCOMPAT".
 However, with the most recent, 2.6.9-rc4-mm1, it doesn't get that
far.  A "Unable to handle kernel paging request at virtual address
00017f8c" happens instead.  I'm guessing the oops is just killing
named before it gets that far.

I enabled some more debug options in the kernel and I'm getting a 2nd
oops following the first.

I wasn't sure if I should paste the huge oops here, and since the raw
dmesg also shows spin lock errors, I thought I'd just post both on the
web:
http://members.cox.net/valenzdu/oops-raw
http://members.cox.net/valenzdu/oops-processed

I ran it through ksymoops but I don't have a /proc/ksyms and when I
tried using /proc/kallsyms it gave me a format error.  I hope this is
helpful, let me know if there is anything else I can do. (CC me
please.)
