Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSIERyR>; Thu, 5 Sep 2002 13:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSIERyR>; Thu, 5 Sep 2002 13:54:17 -0400
Received: from bof.de ([195.4.223.10]:24215 "HELO oknodo.bof.de")
	by vger.kernel.org with SMTP id <S317947AbSIERyQ>;
	Thu, 5 Sep 2002 13:54:16 -0400
Date: Thu, 5 Sep 2002 19:55:47 +0200
From: Patrick Schaaf <bof@bof.de>
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>,
       Harald Welte <laforge@gnumonks.org>,
       Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Schaaf <bof@bof.de>
Subject: Re: ip_conntrack_hash() problem
Message-ID: <20020905195547.A21899@oknodo.bof.de>
References: <1031210342.9785.159.camel@biker.pdb.fsc.net> <20020905115208.4D0A02C064@lists.samba.org> <20020905135440.A10805@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020905135440.A10805@wotan.suse.de>; from ak@suse.de on Thu, Sep 05, 2002 at 01:54:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 01:54:40PM +0200, Andi Kleen wrote:
> > I'll feed this through 2.5, once it's had some more testing (hint
> > hint!).  Then Harald will make a call on 2.4.
> 
> I would propose to include Martin's simple patch as a short term fix 
> for 2.4 until Rusty's full work can get in. It fixes an bad performance
> problems in some not too uncommon cases.

As a short time fix, seeing that it's mostly even hash bucket counts
that give a problem, I would still propose just making the bucket count
the nearest odd number, i.e. basically htable_size |= 1 in the startup code.

I don't expect any user to notice such a miniscule change.

best regards
  Patrick

