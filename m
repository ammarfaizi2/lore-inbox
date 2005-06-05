Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFEXtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFEXtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVFEXt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 19:49:27 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:1689 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261151AbVFEXtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 19:49:22 -0400
Date: Sun, 5 Jun 2005 16:49:21 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Herbert Rosmanith <kernel@wildsau.enemy.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 & latest binutils: asm-problems still there
Message-ID: <20050605234921.GA23960@lucon.org>
References: <200506040329.j543TWV7029456@wildsau.enemy.org> <20050605181632.GA19297@logos.cnet> <20050605233459.GB28759@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605233459.GB28759@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 01:34:59AM +0200, Willy Tarreau wrote:
> On Sun, Jun 05, 2005 at 03:16:32PM -0300, Marcelo Tosatti wrote:
> > On Sat, Jun 04, 2005 at 05:29:31AM +0200, Herbert Rosmanith wrote:
> (...)
> > > alessandro suardi told me that this problem is solved using the
> > > patch from:
> > >   http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch
> > > 
> > > which are dated from march (2005-03-27) and therefore, about 3 months
> > > old.
> > > 
> > > it's about time this gets into the official kernel. who is in charge
> > > of it? (it's obviously not sufficient to report to lkml).
> > 
> > Looks OK except that one "movl" conversion was forgotten in 
> > the x86-64 diff:
> > 
> > @@ -609,7 +609,7 @@ struct task_struct *__switch_to(struct t
> >  	}
> >  	{
> >  		unsigned gsindex;
> > -		asm volatile("movl %%gs,%0" : "=g" (gsindex)); 
> > +		asm volatile("movl %%gs,%0" : "=r" (gsindex)); 
> >  		if (unlikely((gsindex | next->gsindex) || prev->gs)) {
> > 
> > Who wrote the patch? 
> 
> I believe it's H.J. Lu (CC'd).
> 

Is there a problem?


H.J.
