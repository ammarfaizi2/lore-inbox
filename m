Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbRETLUT>; Sun, 20 May 2001 07:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbRETLUJ>; Sun, 20 May 2001 07:20:09 -0400
Received: from t2.redhat.com ([199.183.24.243]:28915 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261854AbRETLUD>; Sun, 20 May 2001 07:20:03 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010518114922.C14309@thyrsus.com> 
In-Reply-To: <20010518114922.C14309@thyrsus.com>  <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> 
To: esr@thyrsus.com
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 12:19:59 +0100
Message-ID: <8485.990357599@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  I'll take that as a vote for (b), to handle even perverse
> configurations  even if it means adding a lot of complexity to the
> ruleset.

As long as the ruleset is sufficient to represent the desired parts of the 
original behaviour of CML1, that should be fine.

Which means that it must be possible to individually select drivers which
aren't standard for your board. The dependencies in CML1 are (supposed to
be) absolute - the 'advisory' dependencies you're adding are arguably a
useful feature, but please don't make it possible to confuse the two, and
please do make sure it's possible to disable the latter form.

I'm one of the people who Jes has heard saying both 'I don't care' and 
'NO!'. The latter on the occasions when it seems you're going to be 
reducing the usablility of the existing system.

I am happiest when my interaction with the config system consists only of 
'cvs {commit,update} .config' 'pico .config' and 'make oldconfig'. I don't 
configure kernels for new boards very often - but on the occasions I do, 
it's often embedded boards based on a reference design, with irrelevant 
hardware omitted and some new stuff added in.

Having the capability to fix up CVS conflicts in 'make oldconfig' would be 
a random feature creep that I _would_ approve of :)

--
dwmw2


