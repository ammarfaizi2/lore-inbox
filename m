Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSL1XhL>; Sat, 28 Dec 2002 18:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSL1XhL>; Sat, 28 Dec 2002 18:37:11 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:46793 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S265570AbSL1XhK>;
	Sat, 28 Dec 2002 18:37:10 -0500
Date: Sun, 29 Dec 2002 00:45:28 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: [BUG] new aic code [was Re: [PATCH] aic7xxx bouncing over 4G ]
Message-ID: <20021228234528.GA8373@werewolf.able.es>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com> <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva> <20021228091608.GA13814@louise.pinerecords.com> <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com> <705128112.1041102818@aslan.scsiguy.com> <Pine.LNX.4.50L.0212281718110.26879-100000@imladris.surriel.com> <20021228194347.GC17051@louise.pinerecords.com> <20021228231122.GC1999@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021228231122.GC1999@werewolf.able.es>; from jamagallon@able.es on Sun, Dec 29, 2002 at 00:11:22 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.28 Tomas Szepe wrote:
> > [riel@conectiva.com.br]
> > 
> > On Sat, 28 Dec 2002, Justin T. Gibbs wrote:
> > 
> > > Unfortunately, the versions of the aic7xxx driver that are in the main
> > > trees (both nearly a year out of date) don't have this test and, like the
> > > "old" driver, they default to memory mapped I/O.  One of the reasons I've
> > > been pushing so hard for this new driver to go into the tree is that 90%
> > > of the complaints about the new driver would go away if it were updated
> > > to a sane revision.
> > 
> > Ohhhh, that would certainly explain.  Where could I get a patch
> > to update a recent 2.4 kernel to your latest aic7xxx driver ?
> > 
> > I'll happily test it on the machines where I have access...
> 
> http://people.freebsd.org/~gibbs/linux/SRC/aic79xx-linux-2.4-20021220.tar.gz
> (Both the 7xxx and 79xx drivers are included.)
> 

When building firmware,
aicasm hangs if you do not select CONFIG_AIC7???_REG_PRETTY_PRINT (no -p
option passed to aicasm, so dfile is NULL inside symtable_dump() for
the fputs...).

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
