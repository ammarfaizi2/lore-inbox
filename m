Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318026AbSGWLLp>; Tue, 23 Jul 2002 07:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318027AbSGWLLo>; Tue, 23 Jul 2002 07:11:44 -0400
Received: from pc-62-30-72-138-ed.blueyonder.co.uk ([62.30.72.138]:35980 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318026AbSGWLLo>; Tue, 23 Jul 2002 07:11:44 -0400
Date: Tue, 23 Jul 2002 12:14:39 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020723121439.B27897@redhat.com>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au> <20020628215942.GA3679@pelks01.extern.uni-tuebingen.de> <20020702131314.B4711@redhat.com> <20020704220511.GA4728@pelks01.extern.uni-tuebingen.de> <20020705085917.F27198@redhat.com> <20020706005834.GA112@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020706005834.GA112@elf.ucw.cz>; from pavel@ucw.cz on Sat, Jul 06, 2002 at 02:58:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 06, 2002 at 02:58:35AM +0200, Pavel Machek wrote:

> So... If I do fsync("/"), will it flush everything? Probably not.

Right, it will only do the root fs.

> Is there some easy way to sync everything to disk and wait for
> completion? [On suspend-to-something I'd llike to do that for
> additional safety.

No, the VFS write_super() method currently has no wait-for-completion
mechanism.

Cheers,
 Stephen
