Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133038AbRDLFhB>; Thu, 12 Apr 2001 01:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133047AbRDLFgw>; Thu, 12 Apr 2001 01:36:52 -0400
Received: from mercury.mv.net ([199.125.85.40]:52492 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S133038AbRDLFgh>;
	Thu, 12 Apr 2001 01:36:37 -0400
Message-ID: <003c01c0c312$73713300$0201a8c0@home>
From: "jeff millar" <jeff@wa1hco.mv.com>
To: <esr@thyrsus.com>
Cc: <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
In-Reply-To: <20010411191940.A9081@thyrsus.com> <E14nU6n-0007po-00@the-village.bc.nu> <20010411204523.C9081@thyrsus.com> <002701c0c2f1$fc672960$0201a8c0@home> <20010411225055.A11009@thyrsus.com>
Subject: Re: CML2 1.0.0 doesn't remember configuration changes
Date: Thu, 12 Apr 2001 01:35:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: <esr@thyrsus.com>
To: jeff millar <jeff@wa1hco.mv.com>
Cc: <linux-kernel@vger.kernel.org>; <kbuild-devel@lists.sourceforge.net>;
Eric S. Raymond <esr@snark.thyrsus.com>
Sent: Wednesday, April 11, 2001 10:50 PM
Subject: Re: CML2 1.0.0 doesn't remember configuration changes
.................

> >
> > The READ.ME says that "make config" will run configtrans to generate
> > .config.  But that doesn't explain why "make config"  doesn't remember
> > changes made to config.out.
> >
> > ideas?
> >
> > jeff
>
> I think it's because I misunderstood how the standard productions are
supposed
> to work.  If you'll tell me what files you expect them to read on startup,
> and in what order, I can emulate that behavior.

I'm probably one of least qualified persons to answer that question.  But
maybe saying something wrong will create the usual flood of corrections.

>From what's in the various documentation and reading about 1% of the cml2
traffic...  cml2's  various "make *config" invocations use config.out as a
database for remembering configuration, and then on exit they all generate a
fresh copy of .config.  Apparently it's too hard to read the existing
.config to generate an initial config.out,  so I think "make *config" the
first time, starts with some default and then on exit _should_ write that to
config.out.  Then any other invocationn of *make *config". needs to use
config.out.  "make xconfig", "make config" and "make editconfig" need to
operate the same way.  I've never use anything but "make xconfig",  "make
menuconfig" and "make oldconfig" and they currently all operate on the same
information.  I've never used editconfig and don't know what it's for.

1.0.3 feels faster, btw.



