Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSGRGwM>; Thu, 18 Jul 2002 02:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSGRGwM>; Thu, 18 Jul 2002 02:52:12 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58891 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315923AbSGRGwL>; Thu, 18 Jul 2002 02:52:11 -0400
Date: Thu, 18 Jul 2002 03:53:55 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: hpa@zytor.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       viro@math.psu.edu, trond.myklebust@fys.uio.no, mnalis-umsdos@voyager.hr,
       aia21@cantab.net, al@alarsen.net, asun@cobaltnet.com,
       bfennema@falcon.csc.calpoly.edu, dave@trylinux.com, braam@clusterfs.com,
       chaffee@cs.berkeley.edu, dwmw2@infradead.org, eric@andante.org,
       hch@infradead.org, jaharkes@cs.cmu.edu, jakub@redhat.com,
       jffs-dev@axis.com, mikulas@artax.karlin.mff.cuni.cz,
       quinlan@transmeta.com, reiserfs-dev@namesys.com, mason@suse.com,
       rgooch@atnf.csiro.au, rmk@arm.linux.org.uk, shaggy@austin.ibm.com,
       tigran@veritas.com, urban@teststation.com, vandrove@vc.cvut.cz,
       vl@kki.org, zippel@linux-m68k.org, ahaas@neosoft.com
Subject: Re: Remain Calm: Designated initializer patches for 2.5
Message-ID: <20020718065355.GA2248@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, hpa@zytor.com,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
	viro@math.psu.edu, trond.myklebust@fys.uio.no,
	mnalis-umsdos@voyager.hr, aia21@cantab.net, al@alarsen.net,
	asun@cobaltnet.com, bfennema@falcon.csc.calpoly.edu,
	dave@trylinux.com, braam@clusterfs.com, chaffee@cs.berkeley.edu,
	dwmw2@infradead.org, eric@andante.org, hch@infradead.org,
	jaharkes@cs.cmu.edu, jakub@redhat.com, jffs-dev@axis.com,
	mikulas@artax.karlin.mff.cuni.cz, quinlan@transmeta.com,
	reiserfs-dev@namesys.com, mason@suse.com, rgooch@atnf.csiro.au,
	rmk@arm.linux.org.uk, shaggy@austin.ibm.com, tigran@veritas.com,
	urban@teststation.com, vandrove@vc.cvut.cz, vl@kki.org,
	zippel@linux-m68k.org, ahaas@neosoft.com
References: <20020718032331.5A36644A8@lists.samba.org> <3D366103.8010403@zytor.com> <20020717.232832.44968023.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717.232832.44968023.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 17, 2002 at 11:28:32PM -0700, David S. Miller escreveu:
>    From: "H. Peter Anvin" <hpa@zytor.com>
>    Date: Wed, 17 Jul 2002 23:32:35 -0700
>    
>    As far as I could tell, *ALL* of these changes broke text alignment in 
>    columns.  It would have been a lot better if they had maintained 
>    spacing; I find the new code much more cluttered and hard to read.
> 
> I have to admit that I hate the new syntax too.  The GCC syntax is
> so much nicer.

Well, I also like the non C99 variant that is in gcc as well, but if gcc is
going to drop that in the future in favour of the C99 standard... But yes,
not having the spacing is _ugly_, what I'm doing is:

static struct proto_ops SOCKOPS_WRAPPED(atalk_dgram_ops) = {
        .family         = PF_APPLETALK,
        .release        = atalk_release,
        .bind           = atalk_bind,
        .connect        = atalk_connect,
        .socketpair     = sock_no_socketpair,
        .accept         = sock_no_accept,
.
.
.

8)

- Arnaldo
