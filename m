Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288055AbSACA2H>; Wed, 2 Jan 2002 19:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288050AbSACA0y>; Wed, 2 Jan 2002 19:26:54 -0500
Received: from monster.nni.com ([216.107.0.51]:48903 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S288052AbSACAZz>;
	Wed, 2 Jan 2002 19:25:55 -0500
From: "Andrew Rodland" <arodland@noln.com>
Subject: Re: CML2 funkiness
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: linux-kernel@vger.kernel.org, David Relson <relson@osagesoftware.com>
X-Mailer: CommuniGate Pro Web Mailer v.3.5
Date: Wed, 02 Jan 2002 19:25:55 -0500
Message-ID: <web-54762829@admin.nni.com>
In-Reply-To: <4.3.2.7.2.20020102100856.00e78f00@mail.osagesoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I had 1.9.16, but it looks like the same problem
 (and it seems like it's been around for a bit).
I'm definitely seeing the same thing as David, except the
 symbols I'm seeing are:

DANGEROUS: Prompt for features that can trash data.
 (DANGEROUS) [ ] (NEW)?:
DEVELOPMENT: Configure a development or 2.5 kernel?
 (EXPERIMENTAL) [ ] (NEW)?:
ISA_CARDS: Support for ISA-bus cards. [Y] (NEW)?:


On Wed, 02 Jan 2002 10:10:42 -0500
 David Relson <relson@osagesoftware.com> wrote:
> At 09:03 AM 1/2/02, Andrew Rodland wrote:
> >First off, I'd like to apologize for lack of all the
> > information I'd like to have, I'm at school, and
> > temporarily semidisconnected at home.
> >
> >CML2 is definitely still not quite right for me
> >(2.4.17 + kpreempt-rml, latest CML2 as of 3ish days
>  ago).
> >
> >Menuconfig and friends seem okay, as far as I can tell
>  (and
> > they've apparently been tested pretty well), but
>  oldconfig
> > is wacky...
> >
> >So, "mv config .config ; make mrproper ; mv config
>  .config
> > ; make oldconfig" does odd things to my config, but
>  more
> > in-your-face, on "make oldconfig ; make oldconfig" (ad
> > inifinitum if you want), it will continue asking the
>  same
> > questions, and never remember the answer.
> 
> Andrew,
> 
> I have just tested this, and have reproduced your
>  problem.  Using kernel-2.4.16 and cml2-1.2.20, i.e. my
>  current kernel and the latest CML2, I ran "make
>  oldconfig" three times.  The first time I answered "n"
>  to 21 queries.  The second and third times, I had to
>  answer "n" to 9 queries.  The 9 all appeared in the
>  first run and were exactly the same in the second and
>  third runs.
> 
> Here're the 9 queries from runs 2 and 3:
> EXPERT: Prompt for expert choices (those with no help
>  attached) (EXPERIMENTAL) [ ] (NEW)?:
> DEVELOPMENT: Configure a development or 2.5 kernel?
>  (EXPERIMENTAL) [ ] (NEW)?:
> CD_NO_IDESCSI: Support CD-ROM drives that are not SCSI or
>  IDE/ATAPI [ ] (NEW)?:
> IP_ADVANCED_ROUTER: Advanced router [ ] (NEW)?:
> NET_VENDOR_SMC: Western Digital/SMC cards [ ] (NEW)?:
> NET_VENDOR_RACAL: Racal-Interlan (Micom) NI cards [ ]
>  (NEW)?:
> NET_POCKET: Pocket and portable adapters [ ] (NEW)?:
> HAMRADIO: Amateur Radio support [ ] (NEW)?:
> FBCON_FONTS: Select other compiled-in fonts [ ] (NEW)?:
> 
> From past testing of CML2 I know it uses file config.out
>  as its 
> "memory".  Looking in it, I didn't see any CONFIG symbols
>  for these symbols.
> 
> There's definitely something here for Eric to fix!
> 
> David
> 
> 

