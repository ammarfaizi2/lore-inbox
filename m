Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285269AbRLFWuG>; Thu, 6 Dec 2001 17:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285284AbRLFWtv>; Thu, 6 Dec 2001 17:49:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8467 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285269AbRLFWso>; Thu, 6 Dec 2001 17:48:44 -0500
Subject: Re: SMP/cc Cluster description
To: lm@bitmover.com (Larry McVoy)
Date: Thu, 6 Dec 2001 22:55:37 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), lm@bitmover.com (Larry McVoy),
        phillips@bonn-fries.net (Daniel Phillips),
        davem@redhat.com (David S. Miller), davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, hps@intermeta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20011206143218.O27589@work.bitmover.com> from "Larry McVoy" at Dec 06, 2001 02:32:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C7QX-0003PC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ftruncate
> 
> I'm not sure what the point is.  We've already agreed that the multiple OS
> instances will have synchonization to do for file operations, ftruncate
> being one of them.
> 
> I thought the question was how N user processes do locking and my answer
> stands: exactly like they'd do it on an SMP, with mutex_enter()/exit() on
> some portion of the mapped file.  The mapped file is just a chunk of cache

ftrucate invalidates that memory under you, on all nodes. That means you do
end up needing cross node locking and your file operations simply won't lie
down and scale cleanly

