Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278045AbRJIWqf>; Tue, 9 Oct 2001 18:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278043AbRJIWq3>; Tue, 9 Oct 2001 18:46:29 -0400
Received: from Expansa.sns.it ([192.167.206.189]:27666 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278036AbRJIWqJ>;
	Tue, 9 Oct 2001 18:46:09 -0400
Date: Wed, 10 Oct 2001 00:46:31 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
cc: "Trever L. Adams" <trever_adams@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
In-Reply-To: <Pine.LNX.4.33.0110091129190.209-100000@desktop>
Message-ID: <Pine.LNX.4.33.0110100045490.24292-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stupid question...
have you got a rule like

iptables -A INPUT -m unclean -j DROP

enabled?


On Tue, 9 Oct 2001, Jeffrey W. Baker wrote:

> On 9 Oct 2001, Trever L. Adams wrote:
>
> > On Tue, 2001-10-09 at 13:07, Jeffrey W. Baker wrote:
> > > I see this too.  iptables is refusing packets on locally-initiated TCP
> > > connections when the RELATED,ESTABLISHED rule should be letting them
> > > through.
> > >
> > > I mentioned this problem on the netfilter list but my message fell into
> > > a black hole and was apparently beyond the horizon of the developers.
> > >
> > > -jwb
> >
> > Maybe I misunderstand you, define locally-initiated.  Do you mean net or
> > do you mean box?  Mine happens on connections made by the firewall
> > (proxy for web) and on other connections initiated internally.  We
> > currently only allow identd and a few others from external (identd is
> > spoofed more or less).
>
> I mean connections originating from userland processes running on the
> machine with iptables configured.  This machine does not act as a NAT or
> router for any other machine.
>
> We make about 200000 outbound connections to web sites in a day.  Of these
> connections, a few thousand get fucked up by iptables (iptables suddenly
> decides to drop packets on this connection).
>
> -jwb
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

