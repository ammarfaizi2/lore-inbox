Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283481AbRLJSzk>; Mon, 10 Dec 2001 13:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285829AbRLJSzV>; Mon, 10 Dec 2001 13:55:21 -0500
Received: from cs182024.pp.htv.fi ([213.243.182.24]:18816 "EHLO
	cs182024.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S283481AbRLJSzB>; Mon, 10 Dec 2001 13:55:01 -0500
Message-ID: <3C1504FE.63B0002F@welho.com>
Date: Mon, 10 Dec 2001 20:54:54 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2
In-Reply-To: <200112101834.VAA17862@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> Well, you can just add one line to tcp_input.c to repair this.

Thanks, that was quick! :)

> Duh, do specs say something about segments with seqs
> above fin? I do not remember.

I don't think they do, aside from that LAST-ACK is a synchronized state.
I.e., if you set RCV.WND to zero after receiving a FIN, any subsequent
out-of-window (below or above) segment will be acked. However, I don't
think it matters much, since above-window packets would in this case
always be caused by a bug in the sender.

> Alexey

	MikaL
