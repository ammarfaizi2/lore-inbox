Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281021AbRKTLG1>; Tue, 20 Nov 2001 06:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281019AbRKTLGQ>; Tue, 20 Nov 2001 06:06:16 -0500
Received: from [195.66.192.167] ([195.66.192.167]:10248 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S281022AbRKTLF7>; Tue, 20 Nov 2001 06:05:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: James A Sutherland <jas88@cam.ac.uk>,
        Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: x bit for dirs: misfeature?
Date: Tue, 20 Nov 2001 13:03:05 +0000
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111191644.fAJGileU019108@pincoya.inf.utfsm.cl> <01111919395802.07749@nemo> <E165tl7-00023G-00@mauve.csi.cam.ac.uk>
In-Reply-To: <E165tl7-00023G-00@mauve.csi.cam.ac.uk>
MIME-Version: 1.0
Message-Id: <01112013030502.00810@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 19:07, James A Sutherland wrote:
> On Monday 19 November 2001 7:39 pm, vda wrote:
> > On Monday 19 November 2001 17:24, James A Sutherland wrote:
> > > > > Yes, I see... All I can do is to add workarounds (ok,ok, 'support')
> > > > > to chmod and friends:
> > > > >
> > > > > chmod -R a+R dir  - sets r for files and rx for dirs
> > > >
> > > > X sets x for dirs, leaves files alone.
> > >
> > > Which sounds like exactly the behaviour the original poster wanted,
> > > AFAICS?
> >
> > Yes, that sounds like the behaviour I want. But X flag does not do that.
> > Sorry.
>
> Oh? I just checked, and X *does* set the x bit on directories only, leaving
> files unaffected. What's wrong with that? Does it not do this on your
> system? Or do you want some other behaviour?

I just checked it too (not olny read the manpage but conducted an
experiment). If a file has any of three x bits set, chmod a+X will
set all three x bits, making it world-executable.

That is not what I want. I want to make whole tree world-readable (and
browsable), i.e. a+r on files and a+rx on dirs. There is no chmod flag
which will do that.

[I'd like to take this silliness off the lkml but jas88@cam.ac.uk
 rejects my direct emails:
   ----- Transcript of session follows -----
... while talking to navy.csi.cam.ac.uk.:
>>> RCPT To:<jas88@cam.ac.uk>
<<< 550 mail from 195.66.192.167 rejected: administrative prohibition (host 
is blacklisted)
550 5.1.1 <jas88@cam.ac.uk>... User unknown  ]
--
vda
