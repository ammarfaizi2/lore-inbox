Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbSLEF6q>; Thu, 5 Dec 2002 00:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbSLEF6n>; Thu, 5 Dec 2002 00:58:43 -0500
Received: from dp.samba.org ([66.70.73.150]:56740 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267238AbSLEF6j>;
	Thu, 5 Dec 2002 00:58:39 -0500
Date: Thu, 5 Dec 2002 17:06:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Miles Bader <miles@gnu.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205060606.GG1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Miles Bader <miles@gnu.org>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
References: <20021205004744.GB2741@zax.zax> <200212050144.gB51iH105366@localhost.localdomain> <20021205023847.GA1500@zax.zax> <buohedtrw64.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buohedtrw64.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 12:17:55PM +0900, Miles Bader wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
> > It seems the "try to get consistent memory, but otherwise give me
> > inconsistent" is only useful on machines which:
> > 	(1) Are not fully consisent, BUT
> > 	(2) Can get consistent memory without disabling the cache, BUT
> > 	(3) Not very much of it, so you might run out.
> > 
> > The point is, there has to be an advantage to using consistent memory
> > if it is available AND the possibility of it not being available.
> ...
> > Are there actually any machines with the properties described above?
> 
> As I mentioned in my previous message, one of my platforms is like that
> memory, which is only 2 megabytes in size.

Ok, that starts to make sense then (what platform is it,
incidentally).  Is using consistent memory actually faster than doing
the cache flushes expliticly?  Much?

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
