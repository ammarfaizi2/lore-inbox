Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTKROCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 09:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTKROCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 09:02:17 -0500
Received: from ns.suse.de ([195.135.220.2]:5337 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262777AbTKROBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 09:01:25 -0500
Date: Tue, 18 Nov 2003 15:01:22 +0100
From: Andi Kleen <ak@suse.de>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, grof@dragon.cz,
       davem@redhat.com
Subject: Re: possible bug in tcp_input.c
Message-Id: <20031118150122.08d117f9.ak@suse.de>
In-Reply-To: <20031118135805.GA9705@louise.pinerecords.com>
References: <20031024162959.GB11154@louise.pinerecords.com.suse.lists.linux.kernel>
	<p73ptgma58b.fsf@oldwotan.suse.de>
	<20031118135805.GA9705@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003 14:58:05 +0100
Tomas Szepe <szepe@pinerecords.com> wrote:

> On Oct-24 2003, Fri, 19:57 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > > /* tcp_input.c, line 1138 */
> > > static inline int tcp_head_timedout(struct sock *sk, struct tcp_opt *tp)
> > > {
> > >   return tp->packets_out && tcp_skb_timedout(tp, skb_peek(&sk->write_queue));
> > > }
> > 
> > tp->packets_out > 0 implies that there is at least one packet in the write 
> > queue (it counts the number of unacked packets in flight, which are kept
> > in the write queue). When that's not the case something else is wrong.
> 
> Yes, that's exactly what davem said.  The corruption is happening somewhere
> in netsched/imq code that's not even part of the official kernel tree (and
> I'm told there's nobody to maintain the patch at present).

Ignore the mail. It was some machine flushing out an old mail queue
(with some very old mails from me that never made it out) 

I actually wrote it before DaveM if you check the dates ;-)

-Andi
