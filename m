Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbRFRQRl>; Mon, 18 Jun 2001 12:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbRFRQRa>; Mon, 18 Jun 2001 12:17:30 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:53258 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S261369AbRFRQR1>; Mon, 18 Jun 2001 12:17:27 -0400
Date: Mon, 18 Jun 2001 09:17:25 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jan Hudec <bulb@ucw.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <20010618135018.A12320@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0106180913560.312-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Jan Hudec wrote:

> Btw: can the aplication somehow ask the tcp/ip stack what was actualy acked?
> (ie. how many bytes were acked).

no, but it's not necessarily a useful number anyhow -- because it's
possible that the remote end ACKd bytes but the ACK never arrives.  so you
can get into a situation where the remote application has the entire
message but the local application doesn't know.  the only way to solve
this is above the TCP layer.  (message duplicate elimination using an
unique id.)

if the #bytes ack'd was available it would probably fool people into
implementing buggy code (which of course they do anyhow :)

-dean

