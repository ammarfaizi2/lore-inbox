Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263994AbRFKURo>; Mon, 11 Jun 2001 16:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263971AbRFKURe>; Mon, 11 Jun 2001 16:17:34 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:28431 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S263994AbRFKUR1>;
	Mon, 11 Jun 2001 16:17:27 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Matthew G. Marsh" <mgm@paktronix.com>
Date: Mon, 11 Jun 2001 22:15:50 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IPX to Netware 5.1
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <58A756348DA@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 01 at 14:56, Matthew G. Marsh wrote:
> On Mon, 11 Jun 2001, Lauri Tischler wrote:
> 
> > I've been mounting Netware volumes from Netware 4.1x to linux for
> > a quite a while now, works just fine.
> > We installed new Netware server with Netware 5.1 and I can't now
> > mount any volumes.  The error message is:
> >   ncpmount: Unknown Server error (0x8901) in nds login
> >   Login denied.
> 
> Yep. We did some testing and found that if the server has a RW replica
> of the partition your user ID exists in then the NDS login will work.
> Otherwise nothing works. Also if you have password restrictions such as
> minumum number of characters then most users must have a password that is
> exactly the minimum number of characters unless they have admin
> (supervisor) priviledges. Has us baffled.
> 
> We ended up making sure that the servers we use have RW replicas and that
> we use full context NDS logins.

Are you sure that you are using ncpfs-2.2.0.18? In that case try
ncpfs-2.2.0.19.pre56 (ftp://platan.vc.cvut.cz/private/ncpfs).

But RO/no replicas should not affect bindery login. Are you sure that
you really tried bindery ncpmount (with -b option)?
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
                                
