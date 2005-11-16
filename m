Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbVKPSsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbVKPSsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbVKPSsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:48:30 -0500
Received: from web34115.mail.mud.yahoo.com ([66.163.178.113]:7283 "HELO
	web34115.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030421AbVKPSsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:48:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=awaAos7RTQuJOFOo1VEEsUM+xKXlYgxygEOjLYZI/mhVQwLP8O0zpQPiUZFYykXyJrHW/63n+XIOCPeJyVXc3hYHaxcckxfYTN7RmD8SrRBlwEnxwZN80zhU0QH0sve6OXjCRdv3YC6SsZHv4+YIui60wg/7d+xcgiTxeU3LquM=  ;
Message-ID: <20051116184829.79932.qmail@web34115.mail.mud.yahoo.com>
Date: Wed, 16 Nov 2005 10:48:28 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1132163057.8811.15.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> OK, please back out the patch that I sent you, and try this one instead.

THAT'S IT!

Very nice..  30MB+/sec sustained for several minutes..
only 25% system CPU and the new profile is:

samples  %        symbol name
1047754  32.9054  pci_conf1_write
193876    6.0888  _spin_lock_irqsave
152897    4.8018  skb_copy_bits
74745     2.3474  _spin_lock
73273     2.3012  __copy_from_user_ll
69273     2.1756  __lookup_tag
65084     2.0440  _spin_unlock_irqrestore
43803     1.3757  sub_preempt_count
32047     1.0065  tcp_v4_rcv
30895     0.9703  schedule
26161     0.8216  kfree

Thank you!

-Kenny



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
