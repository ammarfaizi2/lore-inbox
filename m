Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266023AbUF2Ufu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUF2Ufu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUF2UfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:35:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:7567 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266017AbUF2UfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:35:12 -0400
Date: Tue, 29 Jun 2004 13:35:01 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: debi.janos@freemail.hu, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-Id: <20040629133501.3c2cd2a2@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040629125401.4ca60aa7.davem@redhat.com>
References: <freemail.20040529152006.85505@fm4.freemail.hu>
	<20040629112256.58828632@dell_ss3.pdx.osdl.net>
	<20040629124951.56de307d@dell_ss3.pdx.osdl.net>
	<20040629125401.4ca60aa7.davem@redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004 12:54:01 -0700
"David S. Miller" <davem@redhat.com> wrote:

> 
> What's really amusing in those traces is that it is the sender that
> is doing the window scaling, not the receiver.  The side doing the
> window interpretation for data packet sending is looking at a
> non-scaled window.
> 
> Boggle...

FYI - gentoo works for window scale 0..2 and appears to fail for >3.

Also, the socket ends up with:

State      Recv-Q Send-Q      Local Address:Port          Peer Address:Port
ESTAB      0      0             172.20.1.73:34452       198.63.211.232:http
         ts sack wscale:0,3 rto:332 rtt:66.375/50.5 cwnd:3
