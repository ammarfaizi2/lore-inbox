Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbRFWRrX>; Sat, 23 Jun 2001 13:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbRFWRrO>; Sat, 23 Jun 2001 13:47:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33550 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261684AbRFWRq6>; Sat, 23 Jun 2001 13:46:58 -0400
Date: Sat, 23 Jun 2001 14:30:06 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Eric Lammerts <eric@lammerts.org>
Cc: Rasmus Andersen <rasmus@jaquet.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add kmalloc check in drviers/pcmcia/rsrc_mgr.c (245-ac16)
Message-ID: <20010623143006.A7004@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Eric Lammerts <eric@lammerts.org>,
	Rasmus Andersen <rasmus@jaquet.dk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010623152202.B840@jaquet.dk> <Pine.LNX.4.33.0106231901560.7165-100000@ally.lammerts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0106231901560.7165-100000@ally.lammerts.org>; from eric@lammerts.org on Sat, Jun 23, 2001 at 07:09:37PM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 23, 2001 at 07:09:37PM +0200, Eric Lammerts escreveu:
> 
> On Sat, 23 Jun 2001, Rasmus Andersen wrote:
> 
> > +    if (!b) {
> > +	printk(" -- aborting.\n");
> > +	printk(KERN_ERR "Out of memory.");
> > +	return;
> > +    }
> 
> Why not printk(KERN_ERR "rsrc_mgr: Out of memory.\n"); ?
> Then at least people will know what it was that ran out of memory.

Better yet:

printk(KERN_ERR __FUNCTION__ "Out of memory.");

Then if you move the code to other function or if you change the name of
the function you don't have to go all over the code doing
s/old_function_name/new_function_name/g

- Arnaldo
