Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263378AbRFRWbR>; Mon, 18 Jun 2001 18:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbRFRWbG>; Mon, 18 Jun 2001 18:31:06 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:50441 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S263378AbRFRWav>; Mon, 18 Jun 2001 18:30:51 -0400
Date: Mon, 18 Jun 2001 15:30:50 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Jan Hudec <bulb@ucw.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <a05101000b753df30ddaa@[192.168.239.105]>
Message-ID: <Pine.LNX.4.33.0106181527050.13084-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Jun 2001, Jonathan Morton wrote:

> >  > Btw: can the aplication somehow ask the tcp/ip stack what was
> >actualy acked?
> >>  (ie. how many bytes were acked).
> >
> >no, but it's not necessarily a useful number anyhow -- because it's
> >possible that the remote end ACKd bytes but the ACK never arrives.  so you
> >can get into a situation where the remote application has the entire
> >message but the local application doesn't know.  the only way to solve
> >this is above the TCP layer.  (message duplicate elimination using an
> >unique id.)
>
> No, because if the ACK doesn't reach the sending machine, the sender
> will retry the data until it does get an ACK.

if the network goes down in between, the sender may never get the ACK.
the sender will see a timeout eventually.  the receiver may already be
done with the connection and closed it and never see the error.  if it
were a protocol such as SMTP then the sender would retry later, and the
result would be a duplicate message.  (which you can eliminate above the
TCP layer using unique ids.)

-dean

