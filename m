Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316496AbSFPS0c>; Sun, 16 Jun 2002 14:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSFPS0b>; Sun, 16 Jun 2002 14:26:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24339 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316496AbSFPS0a>; Sun, 16 Jun 2002 14:26:30 -0400
Date: Sun, 16 Jun 2002 11:26:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Urban Widmark <urban@teststation.com>
cc: Erik McKee <camhanaich99@yahoo.com>, <linux-kernel@vger.kernel.org>,
       <kernel-newbies@vger.kernel.org>, <davej@suse.de>,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [ERROR][PATCH] smbfs compilation in 2.5.21
In-Reply-To: <Pine.LNX.4.44.0206161257390.5774-100000@cola.enlightnet.local>
Message-ID: <Pine.LNX.4.44.0206161122140.3316-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Jun 2002, Urban Widmark wrote:
>
> >  # define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__, ## a)
> > +# define PARANOIA2(f) printk(KERN_NOTICE "%s: "f, __FUNCTION__)
>
> Are you looking at BK, the 2.5.21 tree I'm looking at still has:
> #define PARANOIA(x...) printk(KERN_NOTICE __FUNCTION__ ": " x)

Should not

  # define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__ , ##  a)

work? Notice the one added extra space between __FUNCTION__ and ",".

		Linus

