Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262371AbSJEPKw>; Sat, 5 Oct 2002 11:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262372AbSJEPKw>; Sat, 5 Oct 2002 11:10:52 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:21379 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S262371AbSJEPKv>; Sat, 5 Oct 2002 11:10:51 -0400
Date: Fri, 4 Oct 2002 18:32:38 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Christoph Hellwig <hch@infradead.org>, Kevin Corry <corryk@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EVMS core 1/4: evms.c
Message-ID: <20021004183238.O642@nightmaster.csn.tu-chemnitz.de>
References: <02100307355501.05904@boiler> <02100317115209.05904@boiler> <20021004155639.A32001@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20021004155639.A32001@infradead.org>; from hch@infradead.org on Fri, Oct 04, 2002 at 03:56:39PM +0100
X-Spam-Score: -14.0 (--------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *17xqfK-0007nA-00*R7qFMMIzgUE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 03:56:39PM +0100, Christoph Hellwig wrote:
> > + * allocates and zeros an evms_logical_node structure.
> > + *
> > + * returns: 0 if sucessful
> > + *          -ENOMEM if unsuccessful
> > + **/
> > +int
> > +evms_cs_allocate_logical_node(struct evms_logical_node **pp)
> > +{
> > +	*pp = kmalloc(sizeof (struct evms_logical_node), GFP_KERNEL);
> > +	if (*pp == NULL) {
> > +		return -ENOMEM;
> > +	}
> > +	memset(*pp, 0, sizeof (struct evms_logical_node));
> > +	return 0;
> 
> A helper for kmalloc + memset looks rather pointles..
 
This looks, like they want to slabify it later. But a define
might be better here, indeed.


Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
