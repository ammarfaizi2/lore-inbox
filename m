Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBKMy0>; Sun, 11 Feb 2001 07:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129109AbRBKMyR>; Sun, 11 Feb 2001 07:54:17 -0500
Received: from 2-095.cwb-adsl.brasiltelecom.net.br ([200.193.161.95]:15609
	"HELO brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129108AbRBKMyJ>; Sun, 11 Feb 2001 07:54:09 -0500
Date: Sun, 11 Feb 2001 09:12:19 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: davej@suse.de, Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More network pci_enable cleanups.
Message-ID: <20010211091218.B26207@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@mandrakesoft.com>, davej@suse.de,
	Alan Cox <alan@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0102111159430.6348-100000@athlon.local> <3A86819F.799C4311@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3A86819F.799C4311@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Feb 11, 2001 at 07:12:15AM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Feb 11, 2001 at 07:12:15AM -0500, Jeff Garzik escreveu:
> davej@suse.de wrote:
> > > > -       int     cards_found = 0;
> > > > +       int     cards_found;
> > > Rejected.  Introduces bug.  That zero is required!
> > 
> > Refresh my memory here. I thought unitialised vars go to bss,
> > and get zeroed at boot time ?
> 
> cards_found is on the stack, which can contain random crap..

Dave, only static/globals goes to the bss and are thus zeroed, the locals
are in the stack, like Jeff said

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
