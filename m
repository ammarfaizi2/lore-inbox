Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbRBMKUC>; Tue, 13 Feb 2001 05:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130126AbRBMKTw>; Tue, 13 Feb 2001 05:19:52 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:40966 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S129550AbRBMKTs>;
	Tue, 13 Feb 2001 05:19:48 -0500
From: Steve Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200102131019.KAA21847@gw.chygwyn.com>
Subject: Re: SO_RCVTIMEO, SO_SNDTIMEO
To: chris@scary.beasts.org (Chris Evans)
Date: Tue, 13 Feb 2001 10:19:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0102130035550.9858-100000@ferret.lmh.ox.ac.uk> from "Chris Evans" at Feb 13, 2001 12:38:16 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

They are the maximum amount of time that a send or receive call will
block for. The standard socket error returns apply, so if data has
been sent or received, then the return value will be the amount of
data transferred; if no data has been transferred and the timeout
has been reached then -1 is returned with errno=EAGAIN just as if the socket
was specified to be nonblocking. If the timeout is set to zero (the default)
then the operation will never timeout.

Steve.

> 
> 
> Hi,
> 
> I notice the entities in the subject line have appeared in Linux 2.4.
> 
> What is their functional specification? I guess they trigger if no bytes
> are received/send within a consecutive period. How does the app get the
> error? -EPIPE for a blocking read/write? If so, does SIGPIPE
> get raised? Or is -ETIMEDOUT used? ...
> 
> TIA,
> Chris
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://vger.kernel.org/lkml/
> 

