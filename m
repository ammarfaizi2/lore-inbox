Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275277AbRJJK3Y>; Wed, 10 Oct 2001 06:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275278AbRJJK3P>; Wed, 10 Oct 2001 06:29:15 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:46857 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S275277AbRJJK2z>;
	Wed, 10 Oct 2001 06:28:55 -0400
Date: Wed, 10 Oct 2001 07:29:17 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: Adrian Bunk <bunk@fs.tum.de>, Thomas Hood <jdthood@mail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-ac10
Message-ID: <20011010072916.A1016@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rasmus Andersen <rasmus@jaquet.dk>, Adrian Bunk <bunk@fs.tum.de>,
	Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1002676545.5283.4.camel@thanatos> <Pine.NEB.4.40.0110101032320.28053-200000@mimas.fachschaften.tu-muenchen.de> <20011010110905.A28673@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011010110905.A28673@jaquet.dk>; from rasmus@jaquet.dk on Wed, Oct 10, 2001 at 11:09:05AM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 10, 2001 at 11:09:05AM +0200, Rasmus Andersen escreveu:
> On Wed, Oct 10, 2001 at 10:47:40AM +0200, Adrian Bunk wrote:
> [...]
> > 
> > Yes, that was it. Sound works again for me after I've reversed the
> > attached patch to drivers/sound/ad1816.c.
> 
> [...]
> 
> >  
> > -	if (check_region (io_base, 16)) {
> > -		printk ("ad1816: I/O port 0x%03x not free\n", io_base);
> > -		return 0;
> > +	if (request_region(io_base, 16, "AD1816 Sound")) {
> > +		printk(KERN_WARNING "ad1816: I/O port 0x%03x not free\n",
> > +				    io_base);
> > +		goto err;
> >  	}
> >  
> 
> Would you mind trying with a '!' in front of the request_region call?

yup, my fault, sorry, just in case I've checked the other similar patches
I've sent to Alan and they have the '!', thanks for spotting this.

- Arnaldo
