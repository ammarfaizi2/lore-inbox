Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSKHSaR>; Fri, 8 Nov 2002 13:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSKHSaR>; Fri, 8 Nov 2002 13:30:17 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:54014 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261642AbSKHSaP>; Fri, 8 Nov 2002 13:30:15 -0500
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Dave McCracken <dmccr@us.ibm.com>
Subject: Re: 2.5.46-mm1: CONFIG_SHAREPTE do not work with KDE 3
Date: Fri, 8 Nov 2002 19:36:57 +0100
User-Agent: KMail/1.4.7
References: <200211070547.00387.Dieter.Nuetzel@hamburg.de> <200211080150.04839.Dieter.Nuetzel@hamburg.de> <2630000.1036769258@baldur.austin.ibm.com>
In-Reply-To: <2630000.1036769258@baldur.austin.ibm.com>
Cc: Paul Larson <plars@linuxtestproject.org>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JRAz9eWoKFOJPzc"
Message-Id: <200211081936.57344.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_JRAz9eWoKFOJPzc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag, 8. November 2002 16:27 schrieben Sie:
> --On Friday, November 08, 2002 01:50:04 +0100 Dieter N=FCtzel
>
> <Dieter.Nuetzel@hamburg.de> wrote:
> > Any clue for what I should looking for or how we get some useful log?
> > I'll try ksmserver and kdm "by hand".
>
> How do you start KDE?  I'm not a regular KDE user, so I just call ksmserv=
er
> in my .xinitrc file.  What's the proper way to start it?

Don't know...;-)

OK, I think all would be started through "rcxdm" which call "kdm" and "kdm"=
=20
run "startkde" (SuSE 3.1 beta version included).

Wild guess: Could it be "FAST_MALLOC"?

  # Should we really enable FAM support for KDE ?
  export USE_FAM=3D"$KDE_USE_FAM"

  # Should we use the fast malloc function from kdecore ?
  case $KDE_USE_FAST_MALLOC in
    yes|YES|1) KDE_MALLOC=3D1 ;;
  esac

I'll try without it, but have to rebuild my kernel with SHAREPTE before.

=2DDieter
--Boundary-00=_JRAz9eWoKFOJPzc
Content-Type: application/x-bzip2;
  name="startkde.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="startkde.bz2"

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

--Boundary-00=_JRAz9eWoKFOJPzc--

