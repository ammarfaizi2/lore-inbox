Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262044AbRETPew>; Sun, 20 May 2001 11:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbRETPem>; Sun, 20 May 2001 11:34:42 -0400
Received: from t2.redhat.com ([199.183.24.243]:60403 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262044AbRETPea>; Sun, 20 May 2001 11:34:30 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010520111856.C3431@thyrsus.com> 
In-Reply-To: <20010520111856.C3431@thyrsus.com>  <20010518114922.C14309@thyrsus.com> <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> 
To: esr@thyrsus.com
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 16:34:26 +0100
Message-ID: <15823.990372866@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
> I don't understand this request.  I have no concept of `advisory'
> dependencies. What are you talking about?   Is my documentation
> horribly unclear? 

By 'dependency' I refer to the case where the value of one symbol is derived
entirely from, or the range of possible values is limited by, the value of
another symbol.

There are differing reasons for this, which should be treated entirely 
separately.

On one hand you have dependencies which are present to make life easier for 
Aunt Tillie, by refraining from confusing her with strange questions to 
which the answer is _probably_ 'no'. Like the question of whether she has 
an IDE controller on her MVME board.

One the other hand, you have the dependencies present in the existing CML1
configuration, which are _absolute_ dependencies - which specify for example
that you cannot enable support for PCI peripherals if !CONFIG_PCI, etc.
These dependencies are there to prevent you from enabling combinations of
options which are utterly meaningless, and usually won't even compile.

The former type of dependency should^HMUST be optional. Those who know what
they're doing will want to turn them off. I see a lot of boards based on
some reference design or other but with a few tweaks and added or removed
devices - that's what the reference designs are there for; after all. 

By making a distinction between the two types of dependency in the
configuration language, you can pander to Aunt Tillie without actually
getting on the tits of those who don't wish to be arbitrarily restricted
from enabling support for the device they _know_ is present because they
just soldered it to the blinkin' circuit board. :)

--
dwmw2


