Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267272AbSKPNnj>; Sat, 16 Nov 2002 08:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbSKPNnj>; Sat, 16 Nov 2002 08:43:39 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14078 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267272AbSKPNni>; Sat, 16 Nov 2002 08:43:38 -0500
Date: Sat, 16 Nov 2002 14:50:30 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Jeff Garzik <jgarzik@pobox.com>,
       kaos@ocs.com.au, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Modules in 2.5.47-bk...
Message-ID: <20021116135030.GE10408@fs.tum.de>
References: <20021114042738.2091E2C080@lists.samba.org> <m2bs4si29f.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2bs4si29f.fsf@vador.mandrakesoft.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 04:45:16PM +0100, Thierry Vignaud wrote:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> 
> > > The backward compat thing is really a hack, and not system
> > > software done right :( modutils should not need to rename all its
> > > binaries *.old -- and have that be the default that users see when
> > > installing the rpm.  No company worth its shareholders would
> > > release a package full of "*.old" binaries.  Come on...
> > 
> > OK, would calling it "*-2.4" or something help?
> 
> most distros come with some alternative system (at lest, debian, mdk &
> rh), so this problem can legally be left to vendors.

The alternative system doesn't work in this case because it doesn't help
you when you want to switch between 2.4 and 2.6 kernels. You need some
kind of wrapper.

The code that does

if kernel < 2.5.x
  if xxx-2.4 exists
    run xxx-2.4
  else
    error: no xxx-2.4
  fi
else
  do_something
fi

should be included in the new modutils.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

