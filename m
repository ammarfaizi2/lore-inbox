Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268494AbTBOBow>; Fri, 14 Feb 2003 20:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268500AbTBOBow>; Fri, 14 Feb 2003 20:44:52 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:2219 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268494AbTBOBov>; Fri, 14 Feb 2003 20:44:51 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 15 Feb 2003 12:53:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15949.40369.601166.550803@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: Routing problem with udp, and a multihomed host in 2.4.20
In-Reply-To: message from Herbert Xu on Saturday February 15
References: <15948.13879.734412.313081@notabene.cse.unsw.edu.au>
	<E18jpaa-0007Rc-00@gondolin.me.apana.org.au>
X-Mailer: VM 7.07 under Emacs 20.7.2
FCC: ~/.mail/linux
X-face:	[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
--text follows this line--
On Saturday February 15, herbert@gondor.apana.org.au wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > 
> > It turns out that the problem occurs when send_msg is used to send a
> > UDP packet, and the control information contains
> >              struct in_pktinfo {
> >                  unsigned int   ipi_ifindex;  /* Interface index */
> >                  struct in_addr ipi_spec_dst; /* Local address */
> >                  struct in_addr ipi_addr;     /* Header Destination address */
> >              };
> > specifying the address and interface of the message that we are
> > replying to.
> 
> So your application is forcing the packet to go out on a specific
> interface bypassing the routing table...

No.
My application (which is just using standard rpc server libraries) is
saying
  "This is in reply to a request that came in through a given
  interface".

It is not reasonable to treat that statement as equivalent to:
  "This packet must go out that interface"

which is what appears to be happening.

NeilBrown


> -- 
> Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
> Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
