Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280320AbRKSRYP>; Mon, 19 Nov 2001 12:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280328AbRKSRXz>; Mon, 19 Nov 2001 12:23:55 -0500
Received: from [195.66.192.167] ([195.66.192.167]:63501 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280307AbRKSRXj>; Mon, 19 Nov 2001 12:23:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 19:21:57 +0000
X-Mailer: KMail [version 1.2]
Cc: James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <200111191644.fAJGileU019108@pincoya.inf.utfsm.cl>
In-Reply-To: <200111191644.fAJGileU019108@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Message-Id: <01111919215701.07749@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 16:44, Horst von Brand wrote:
> > > Anyway, as Al Viro has pointed out, R!=X. It's been like that for a
> > > very long time, it's deliberate, not a misfeature, and it's staying
> > > like that for the foreseeable future.
> >
> > Yes, I see... All I can do is to add workarounds (ok,ok, 'support')
> > to chmod and friends:
> >
> > chmod -R a+R dir  - sets r for files and rx for dirs
>
> X sets x for dirs, leaves files alone.

Hmm... yes this is one of such workarounds already implemented.
But it is not very good for my example:
X sets x for dirs *and* for files with x set for any of u,g,o.

# chmod -R a+rX dir

will make any executables (even root only) world-executable.

That's why I'd like to add new flag to chmod: R.
--
vda
