Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263534AbRFAObO>; Fri, 1 Jun 2001 10:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263537AbRFAObE>; Fri, 1 Jun 2001 10:31:04 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:53172 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S263534AbRFAOau>; Fri, 1 Jun 2001 10:30:50 -0400
Date: Fri, 1 Jun 2001 16:30:42 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: jamal <hadi@cyberus.ca>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (forrealthis
In-Reply-To: <Pine.GSO.4.30.0106011006220.10502-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0106011620340.18082-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, jamal wrote:

> Jeff, Thanks for copying netdev. Wish more people would do that.

Shame on me, I should have thought of that too... I joined lkml only about
2 weeks ago because netdev related topics are sometimes discussed only
there...

> Not really.
>
> One idea i have been toying with is to maintain hysteris or threshold of
> some form in dev_watchdog;

AFAIK, dev_watchdog is right now used only for Tx (if I'm wrong, please
correct me!). So how do you sense link loss if you expect only high Rx
traffic ?

> example: if watchdog timer expires threshold times, you declare the link
> dead and send netif_carrier_off netlink message.
> On recovery, you send  netif_carrier_on

I assume that you mean "on recovery" as in "first succesful hard_start_xmit".

> Assumption:
> If the tx path is blocked, more than likely the link is down.

Yes, but is this a good approximation ? I'm not saying that it's not, I'm
merely asking for counter-arguments.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De


