Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277892AbRJISaQ>; Tue, 9 Oct 2001 14:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277888AbRJISaH>; Tue, 9 Oct 2001 14:30:07 -0400
Received: from c009-h018.c009.snv.cp.net ([209.228.34.131]:57015 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S277890AbRJIS3v>;
	Tue, 9 Oct 2001 14:29:51 -0400
X-Sent: 9 Oct 2001 18:30:18 GMT
Date: Tue, 9 Oct 2001 11:31:28 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: "Trever L. Adams" <trever_adams@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
In-Reply-To: <1002648616.2580.18.camel@aurora>
Message-ID: <Pine.LNX.4.33.0110091129190.209-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Oct 2001, Trever L. Adams wrote:

> On Tue, 2001-10-09 at 13:07, Jeffrey W. Baker wrote:
> > I see this too.  iptables is refusing packets on locally-initiated TCP
> > connections when the RELATED,ESTABLISHED rule should be letting them
> > through.
> >
> > I mentioned this problem on the netfilter list but my message fell into
> > a black hole and was apparently beyond the horizon of the developers.
> >
> > -jwb
>
> Maybe I misunderstand you, define locally-initiated.  Do you mean net or
> do you mean box?  Mine happens on connections made by the firewall
> (proxy for web) and on other connections initiated internally.  We
> currently only allow identd and a few others from external (identd is
> spoofed more or less).

I mean connections originating from userland processes running on the
machine with iptables configured.  This machine does not act as a NAT or
router for any other machine.

We make about 200000 outbound connections to web sites in a day.  Of these
connections, a few thousand get fucked up by iptables (iptables suddenly
decides to drop packets on this connection).

-jwb

