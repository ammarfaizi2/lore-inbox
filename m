Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264016AbRFKV7T>; Mon, 11 Jun 2001 17:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264025AbRFKV7K>; Mon, 11 Jun 2001 17:59:10 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:33545 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S264016AbRFKV7C>; Mon, 11 Jun 2001 17:59:02 -0400
Date: Mon, 11 Jun 2001 16:01:54 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: "Matthew G. Marsh" <mgm@paktronix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: IPX to Netware 5.1
Message-ID: <20010611160154.A17925@vger.timpanogas.org>
In-Reply-To: <58A756348DA@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <58A756348DA@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Mon, Jun 11, 2001 at 10:15:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2001 at 10:15:50PM +0000, Petr Vandrovec wrote:
> On 11 Jun 01 at 14:56, Matthew G. Marsh wrote:
> > On Mon, 11 Jun 2001, Lauri Tischler wrote:
> > 
> > > I've been mounting Netware volumes from Netware 4.1x to linux for
> > > a quite a while now, works just fine.
> > > We installed new Netware server with Netware 5.1 and I can't now
> > > mount any volumes.  The error message is:
> > >   ncpmount: Unknown Server error (0x8901) in nds login
> > >   Login denied.
> > 
> > Yep. We did some testing and found that if the server has a RW replica
> > of the partition your user ID exists in then the NDS login will work.
> > Otherwise nothing works. Also if you have password restrictions such as
> > minumum number of characters then most users must have a password that is
> > exactly the minimum number of characters unless they have admin
> > (supervisor) priviledges. Has us baffled.
> > 
> > We ended up making sure that the servers we use have RW replicas and that
> > we use full context NDS logins.
> 
> Are you sure that you are using ncpfs-2.2.0.18? In that case try
> ncpfs-2.2.0.19.pre56 (ftp://platan.vc.cvut.cz/private/ncpfs).
> 
> But RO/no replicas should not affect bindery login. Are you sure that
> you really tried bindery ncpmount (with -b option)?
>                                         Best regards,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>                                                 

Petr,

I think they may be seeing what I am seeing with ipx config underneath.

Jeff



>                                 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
