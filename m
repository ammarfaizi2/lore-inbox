Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTJWKbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 06:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTJWKbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 06:31:06 -0400
Received: from rth.ninka.net ([216.101.162.244]:64397 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263441AbTJWKbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 06:31:04 -0400
Date: Thu, 23 Oct 2003 03:31:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: an7 <an3h0ny@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Useless networking code in 2.4.x ?
Message-Id: <20031023033100.1bc47d31.davem@redhat.com>
In-Reply-To: <20031023085801.40580.qmail@web11105.mail.yahoo.com>
References: <20031023085801.40580.qmail@web11105.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Oct 2003 10:58:01 +0200 (CEST)
an7 <an3h0ny@yahoo.fr> wrote:

> If we have a look at tcp_recv_skb, and
> tcp_read_sock(),
>
> we notice that there is a SYN check, and if the flag
> is on, we do offset-- (sequence number not
> corresponding to real data byte). 
>
> This Syn check is useless, as the function cannot be
> called at the beginning of a connection (since we have
> not copied_seq filled with the last sequence number of
> the last packet passed to the upper layer)
> 
> What do you think of that ?

Please next time, take this kind of question to netdev@oss.sgi.com
where the networking developers are, most of them are not subscribed
to linux-kernel.

As to your question, if we ever support accepting data in the
initial final SYN-ACK packet, this code would be needed, so it's
better to keep this code around.

