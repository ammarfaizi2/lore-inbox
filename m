Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281217AbRLBSpT>; Sun, 2 Dec 2001 13:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281827AbRLBSpJ>; Sun, 2 Dec 2001 13:45:09 -0500
Received: from mercury.mv.net ([199.125.85.40]:16615 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S281217AbRLBSov>;
	Sun, 2 Dec 2001 13:44:51 -0500
Message-ID: <003401c17b61$02f5ec80$0201a8c0@home>
From: "jeff millar" <jeff@wa1hco.mv.com>
To: <dalecki@evision.ag>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Larry McVoy" <lm@bitmover.com>,
        "Davide Libenzi" <davidel@xmailserver.org>,
        "Andrew Morton" <akpm@zip.com.au>,
        "Daniel Phillips" <phillips@bonn-fries.net>,
        "Henning Schmiedehausen" <hps@intermeta.de>,
        "Jeff Garzik" <jgarzik@mandrakesoft.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <E16AZhj-0003pe-00@the-village.bc.nu>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Date: Sun, 2 Dec 2001 13:41:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: <dalecki@evision.ag>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "Larry McVoy" <lm@bitmover.com>;
"Davide Libenzi" <davidel@xmailserver.org>; "Andrew Morton"
<akpm@zip.com.au>; "Daniel Phillips" <phillips@bonn-fries.net>; "Henning
Schmiedehausen" <hps@intermeta.de>; "Jeff Garzik"
<jgarzik@mandrakesoft.com>; <linux-kernel@vger.kernel.org>
Sent: Sunday, December 02, 2001 11:42 AM
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]


> > > Question: What happens when people stick 8 threads of execution on a
die with
> > > a single L2 cache ?
> >
> > That had been already researched. Gogin bejoind 2 threads on a single
> > CPU
> > engine doesn't give you very much... The first step is giving about 25%
> > the second only about 5%. There are papers in the IBM research magazine
> > on
>
> The IBM papers make certain architectural assumptions. With some of the
> tiny modern CPU cores its going to perfectly viable to put 4 or 8 of them
> on one die. At that point cccluster still has to have cluster nodes
scaling
> to 8 way

Semiconductor technology will push this way because it's no longer possible
to propagate a signal across the die in one clock cycle.  This means
pipeline
interlocking becomes vastly more complicated.  The simple solution puts
several CPU cores on the die, each able to interlock in one clock but
sharing
memory over several clocks.

