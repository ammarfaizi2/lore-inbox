Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751337AbWFETrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWFETrB (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 15:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWFETrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 15:47:00 -0400
Received: from mout2.freenet.de ([194.97.50.155]:58034 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1751324AbWFETrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 15:47:00 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: dean gaudet <dean@arctic.org>
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Date: Mon, 5 Jun 2006 21:46:55 +0200
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
References: <200606041516.46920.jfritschi@freenet.de> <200606051206.50085.jfritschi@freenet.de> <Pine.LNX.4.64.0606051037540.6023@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.64.0606051037540.6023@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606052146.55730.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 June 2006 19:44, dean gaudet wrote:
> On Mon, 5 Jun 2006, Joachim Fritschi wrote:
> > Here are the outputs from the tcrypt speedtests. They haven't changed
> > much since the last patch:
> >
> > http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-c-i586.tx
> >t
> > http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-asm-i586.
> >txt
> > http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-c-x86_64.
> >txt
> > http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-asm-x86_6
> >4.txt
>
> when you quote anything related to cpu performance on an x86 processor
> it's absolutely essential to indicate which cpu it is... basically
> vendor_id, cpu family, and model from /proc/cpuinfo.  (for example the
> entire p4 family has incredible model-to-model variation on things like
> shifts and extensions.)

x86_64 benchmarks  where done on a:
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.000
cache size      : 1024 KB
SMP was disabled

x86 benchmarks where done on a:
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2400+
stepping        : 1
cpu MHz         : 1991.695
cache size      : 256 KB

> > > > +/* Defining a few register aliases for better reading */
> > >
> > > Maybe you can read it now better, but for everybody else it is extremly
> > > confusing. It would be better if you just used the original register
> > > names.
>
> i'd change the comment to:
>
> /* define a few register aliases to simplify macro substitution */
>
> because as you mention, it's totally impossible to write the macros
> otherwise.  (i've used the same trick myself a bunch of times.)

Sounds ok to me. It was the main reason to use these aliases. For me it also 
improves readability but as author my view is probably a bit distorted ;)

Joachim

