Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbRK0XDy>; Tue, 27 Nov 2001 18:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282983AbRK0XDo>; Tue, 27 Nov 2001 18:03:44 -0500
Received: from vti01.vertis.nl ([145.66.4.26]:52494 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S281809AbRK0XDb>;
	Tue, 27 Nov 2001 18:03:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
To: Martin Josefsson <gandalf@marcelothewonderpenguin.com>
Subject: Re: [BUG] vanilla 2.4.15 iptables/REDIRECT kernel oops
Date: Tue, 27 Nov 2001 23:55:53 -0800
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
In-Reply-To: <Pine.LNX.4.21.0111271600420.23169-100000@tux.rsn.bth.se>
In-Reply-To: <Pine.LNX.4.21.0111271600420.23169-100000@tux.rsn.bth.se>
MIME-Version: 1.0
Message-Id: <01112723555300.01996@home01>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK. So there hasn't been much response for this BUG report. So I did a little 
investigating myself.

By use of objdump I get the impression that the Oops shows up when 
ip_dont_fragment is called (expanded). To be more specific: sk seems to be 
NULL.

This is rather weird. ip_queue_xmit2 is also the caller of nf_hook_slow (via 
ip_queue_xmit) at which time skb->sk must be OK. After nf_hook_slow things 
suddenly are wrong.

For the interrested I can send a disassembly listing with matching C lines.

On Tuesday 27 November 2001 07:02, Martin Josefsson wrote:
> On Tue, 27 Nov 2001, Rolf Fokkens wrote:
>
> I've forwarded this report to the place where it should be reported, the
> netfilter-devel@lists.samba.org mailinglist as I havn't seen this report
> there.

Haven't had much response from either list. So I just report this to both.
