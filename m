Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263941AbUDVLf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263941AbUDVLf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUDVLf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 07:35:28 -0400
Received: from chaos.analogic.com ([204.178.40.224]:33408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263941AbUDVLfW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 07:35:22 -0400
Date: Thu, 22 Apr 2004 07:35:54 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Giuliano Pochini <pochini@shiny.it>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, cfriesen@nortelnetworks.com,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
In-Reply-To: <XFMail.20040422102359.pochini@shiny.it>
Message-ID: <Pine.LNX.4.53.0404220734330.8039@chaos>
References: <XFMail.20040422102359.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Giuliano Pochini wrote:

>
> On 21-Apr-2004 David S. Miller wrote:
> > On Wed, 21 Apr 2004 19:03:40 +0200
> > Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> >> Heise.de made it appear, as if the only news was that with tcp
> >> windows, the propability of guessing the right sequence number is not
> >> 1:2^32 but something smaller.  They said that 64k packets would be
> >> enough, so guess what the window will be.
> >
> > Yes, that is their major discovery.  You need to guess the ports
> > and source/destination addresses as well, which is why I don't
> > consider this such a serious issue personally.
>
> Yes, but it is possible, expecially for long sessions. Also,
> data injections is also possible with the same method, because
> the receiver accepts everything inside the window, which is
> usually 64k. Out of curiosity: in case Linux receives two
> packets relative to the same portion of the stream, does it
> check if the overlapping data is the same ? It would add extra
> security about data injection in case the data has not been
> sent to userspace yet.
>
>

Has anybody checked to see what Linux does if it receives a
RST to the broadcast address? It would be a shame if all
connections were dropped!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


