Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVAIA5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVAIA5I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 19:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVAIA5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 19:57:08 -0500
Received: from colin2.muc.de ([193.149.48.15]:7186 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262171AbVAIA5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 19:57:05 -0500
Date: 9 Jan 2005 01:57:04 +0100
Date: Sun, 9 Jan 2005 01:57:04 +0100
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Schwab <schwab@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
Message-ID: <20050109005704.GA25274@muc.de>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <je8y73zl35.fsf@sykes.suse.de> <m1zmzjv757.fsf@muc.de> <1105227025.12004.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105227025.12004.2.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 11:30:25PM +0000, Alan Cox wrote:
> On Sad, 2005-01-08 at 23:21, Andi Kleen wrote:
> > > I don't think it was ever being used for anything besides a.out so IMHO it
> > > should depend on BINFMT_AOUT.
> > 
> > I will disable it from 64bit x86-64. I would recommend that all other
> > ELF only architectures do the same.
> 
> Presumably x86-64 runs 32bit a.out binaries however ? Disabling it now
> is a bit pointless since its finally been audited 8)

Yes. I disabled it only for 64bit programs of course. For 32bit it is
dependent on CONFIG_IA32_AOUT.

Actually you can still call it from 64bit if you really want if you use 
int 0x80.

-Andi
