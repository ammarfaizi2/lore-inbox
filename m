Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132362AbRCZH3v>; Mon, 26 Mar 2001 02:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132360AbRCZH3l>; Mon, 26 Mar 2001 02:29:41 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:25357 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132371AbRCZH3b>;
	Mon, 26 Mar 2001 02:29:31 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML1 cleanup patch 
In-Reply-To: Your message of "Mon, 26 Mar 2001 02:09:02 EST."
             <20010326020902.C11181@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Mar 2001 17:28:44 +1000
Message-ID: <23860.985591724@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001 02:09:02 -0500, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>Jeff Garzik <jgarzik@mandrakesoft.com>:
>> If we are moving to CML2 in 2.5, I see no point in big CML1 cleanups.
>
>Yes, I know, that's what I said about Peter's DERIVED patch a week ago.

Hey, that was my DERIVED patch, not Peter's.  Point the blame where it
is due, even I think that my patch was a bad idea.  -ENOTENOUGHCOFFEE.

The 20 cris variables must be renamed to CONFIG_xxx, otherwise make dep
will not find them and config changes will only cause partial
recompiles - or do the cris people like inconsistent kernels?

Correcting the two old names is obviously the right thing to do.

That just leaves the 17 names of the form CONFIG_[0-9]*.  Only the 8139
is likely to affect outside the kernel and the argument that renaming
config options might affect external packages does not hold.  The
recent aic7xxx change broke pcmcia on 2.2 kernels but we can work round
it.

