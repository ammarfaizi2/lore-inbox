Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292371AbSBPOwT>; Sat, 16 Feb 2002 09:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292373AbSBPOwI>; Sat, 16 Feb 2002 09:52:08 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:5105 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292371AbSBPOv4>; Sat, 16 Feb 2002 09:51:56 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020216085706.H23546@thyrsus.com> 
In-Reply-To: <20020216085706.H23546@thyrsus.com>  <20020216013538.A23546@thyrsus.com> <20020215135557.B10961@thyrsus.com> <20020215224916.L27880@suse.de> <20020215170459.A15406@thyrsus.com> <20020215232517.FXLQ71.femail38.sdc1.sfba.home.com@there> <20020216013538.A23546@thyrsus.com> <22614.1013851279@redhat.com> 
To: esr@thyrsus.com
Cc: Rob Landley <landley@trommello.org>, Dave Jones <davej@suse.de>,
        Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Feb 2002 14:51:35 +0000
Message-ID: <30686.1013871095@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



esr@thyrsus.com said:
> David Woodhouse <dwmw2@infradead.org>:
> > However - the thing to which I and many others object most strongly is the 
> > rulebase policy changes which appear to be inseparable from the change in 
> > mechanism. That is; we've tried to get you to separate them, and failed.

> Failed?  Hardly.

> The only rulebase policy change Tom Rini was able to identify in a
> recent review was the magic behavior of EXPERT with respect to entries
> without help.  Which I then removed by commenting out a single
> declaration.

> There is a widespread myth that the CML2 rulebase is lousy with
> "policy changes".  I don't know how it got started, but it needs to
> die now. 

Each time I've even glanced at it, I've seen bogus changes. I haven't 
looked at it recently, so cannot refute your statement that they are now 
all gone. You'll forgive me if I take your assertion with a pinch of salt, 
though?

A good way to kill this myth, if myth it is, would be to set up a test 
suite, as I suggested before. You already have a 'randomconfig' for CML2, I 
believe? I think there's also one for CML1.

Repeatedly make a random config (for a random architecture), with either
CML1 or CML2. Make oldconfig with the other CML, then with the first again.
If there are any differences between the original randomconfig output and
the output after the two 'oldconfig' stages, you've hit something that may
be a problem. 

Every time you hit such a difference, either fix it or document it and 
justify it. Ensure that the list of such justifications required is small, 
in order to improve the chance of CML2 being accepted. 

You are permitted to fix these differences by modifications to the CML1 
rules. The only cases where you should accept differences are where the 
CML1 behaviour does not accurately represent the intention of the 
developer, the developer has agreed with you, _and_ CML2 cannot implement 
the same buggy behaviour.

Note the third condition there. If CML2 _can_ implement the buggy CML1 
behaviour, do so -- you can fix the rules _later_. 




--
dwmw2


