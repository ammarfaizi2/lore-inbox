Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289982AbSAKPNG>; Fri, 11 Jan 2002 10:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289984AbSAKPMs>; Fri, 11 Jan 2002 10:12:48 -0500
Received: from [62.245.135.174] ([62.245.135.174]:52667 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S289979AbSAKPMc> convert rfc822-to-8bit;
	Fri, 11 Jan 2002 10:12:32 -0500
Message-ID: <3C3EED15.F4763543@TeraPort.de>
Date: Fri, 11 Jan 2002 14:48:05 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: roy@karlsbakk.net
Subject: Re: Fixing the vm or merging rmap into the official tree?
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/11/2002 02:48:05 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/11/2002 04:12:31 PM,
	Serialize complete at 01/11/2002 04:12:31 PM
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixing the vm or merging rmap into the official tree?
> 
> From: Roy Sigurd Karlsbakk (roy@karlsbakk.net)
> Date: Thu Jan 10 2002 - 04:55:39 EST
> 
> 
> Hi all
> 
> After weeks of testing, knocking my head against all sorts of objects,
> trying out other potential OSes etc. etc. ad. infinitum, I got the hint of
> using the rmap patch to fix my problems with reading multiple large files
> at once (see prevois thread with subject "[BUG] Error reading multiple
> large files").
> 
> Will this problem be addressed in 2.4 or perhaps 2.[56] ?
> 
> My testing shows that the current vm can't handle high/non-standards load
> efficiently. Isn't this something that clearly should be addressed?
>

 Just my 2 EURO-ct on this. The VM in 2.4.x mainline is definitely
broken for a lot of loads, especially under high memory stress. This
needs to be adressed and fixed ASAP. An I think most people here agree.

 Now, the question is what is the correct fix. There is Andreas´s stuff,
which fixes some scenarios. There is Rick's stuff which fixes others.
There is even the small few liner patch to vmscan.c by M.v.Leuwen, which
fixes/reduces the swapout problem for *my* situation.

 But frankly speaking, I personally don't care which solution goes in,
but it should be done quick. Patching up mainline every time just to get
decent VM behaviour is unacceptable for serious use.

> roy
> 
> --
> Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
------------------------^^^^^^^^^^

 poor guy :-)

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
