Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274562AbRITQas>; Thu, 20 Sep 2001 12:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274561AbRITQaj>; Thu, 20 Sep 2001 12:30:39 -0400
Received: from pD9E1CC8C.dip.t-dialin.net ([217.225.204.140]:13578 "EHLO
	dexter.netego.de") by vger.kernel.org with ESMTP id <S274562AbRITQaZ>;
	Thu, 20 Sep 2001 12:30:25 -0400
Message-Id: <200109201630.f8KGUQ802364@dexter.netego.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
From: "Florian Schaefer" <listbox@netego.de>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: codalist@TELEMANN.coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: [PATCH] Re: Coda and Ext3
X-Mailer: Pronto v2.2.6 On linux/mysql
Date: 20 Sep 2001 17:30:23 CET
Reply-To: "Florian Schaefer" <listbox@netego.de>
In-Reply-To: <20010920120648.A11130@cs.cmu.edu>
In-Reply-To: <3B9792FB.7020708@progress.com>
    <20010906115302.B826@cs.cmu.edu> <1000909441.2017.20.camel@pcsshah>
    <20010919213713.D8947@cs.cmu.edu>
    <200109201238.f8KCcSo00731@dexter.netego.de>
    <20010920120648.A11130@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001 12:06:49 -0400, Jan Harkes said:

> If you look at the trace, parts of it look right, but most of it doesn't
> make sense, printk never calls back into FS specific code, coda_iget
> does not call coda_cnode make, coda_inocmp isn't calling iget4, etc.

Thank you for looking at my problem. :-)

> Try to start from a fresh 2.4.9 tree, apply the ext3 patch and my Coda

This is exactly what I did just some hours ago (oh, I had to add an
aditional patch for the latest acpi daemon, but it just patches one
single acpi file).

> patch, add -fs1 to EXTRAVERSION just to force this tree to install it's

Sorry, but I've never heard of this extraversion stuff. I found it in the
main Makefile of the kernel, do I have to add the option there?

> modules in a separate directory. 

Till now, I always tried to compile it directly into the kernel to be
able to boot from an ext3 partition. Does this make a difference? This
way I never had to touch my working modules.

> Copy the config of your existing tree,
> make oldconfig ; make dep ; etc...

make oldconfig? Doesn't make dep use the .config file directly?

As you can see, I have to admit that I'm quite confused. But I'll try to
sum up what I've understood: You want me to take a new copy of the
kernel, patch ext3 and your last patch into it, add some fancy options to
prevent me from ruining my current system and try it again.
But this is quite exactly what I did (aside from not compiling it as a
module).
One more thing: I can reproduce the BUG on my second computer with the a
similar setup.

Ciao
Florian

PS: I know that I haven't made your life easier with this mail, but
that's the way it is. Sorry.
