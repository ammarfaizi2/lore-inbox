Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318833AbSHESyy>; Mon, 5 Aug 2002 14:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318835AbSHESyy>; Mon, 5 Aug 2002 14:54:54 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51965 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318833AbSHESyx>; Mon, 5 Aug 2002 14:54:53 -0400
Subject: Re: Disk (block) write strangeness
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020805184921.GC2671@unthought.net>
References: <20020805184921.GC2671@unthought.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 21:17:12 +0100
Message-Id: <1028578632.18156.71.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 19:49, Jakob Oestergaard wrote:
> *) Either the disk writes backwards  (no I don't believe that)
> *) Or the kernel is writing 256 B blocks (AFAIK it can't)
> *) The disk has some internal magic that cause a power-loss during
>    a full block write to leave the first half of the block intact with
>    old data, and update the second half of a block correctly with new
>    data.  (And I don't believe that either).

You forgot to add

*) or the disk internal logic bears no resemblance to the antiquated API
it fakes for the convenience of interface hardware and software

Linux also won't neccessarily do write outs in order. 

