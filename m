Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSDOVpv>; Mon, 15 Apr 2002 17:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313309AbSDOVpu>; Mon, 15 Apr 2002 17:45:50 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:51189 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313305AbSDOVpt>; Mon, 15 Apr 2002 17:45:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Mark Mielke <mark@mark.mielke.cc>
Subject: Re: [PATCH] Futex Generalization Patch
Date: Mon, 15 Apr 2002 16:46:24 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Bill Abt <babt@us.ibm.com>, drepper@redhat.com,
        linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <OF24E0B753.2B92A422-ON85256B9C.00512368@raleigh.ibm.com> <20020415172204.4B6073FE08@smtp.linux.ibm.com> <20020415165740.A28056@mark.mielke.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020415214532.1F3553FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 April 2002 04:57 pm, Mark Mielke wrote:
> On Mon, Apr 15, 2002 at 12:22:59PM -0400, Hubertus Franke wrote:
> > typedef struct siginfo {
> >    ...
> >         union {
> >                 int _pad[SI_PAD_SIZE];
> >
> >                 struct {
> >                         ...
> >                 } _kill;
> >  ...
> >
> > I'd suggest we tag along the _sigfault semantics.
> > We don't need to know who woke us up, just which <addr> got signalled.
>
> Is there issues with creating a new struct in the union that represents
> exactly what you wish it to represent?
>
> mark

No, but then again there seems to be no need either.
All we need is the <addr> that is to be woken up, which
carries similarity to a SEGV signal handler.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
