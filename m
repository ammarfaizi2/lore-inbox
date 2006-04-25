Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWDYTp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWDYTp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWDYTp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:45:28 -0400
Received: from mx1.suse.de ([195.135.220.2]:45224 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751276AbWDYTp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:45:27 -0400
Date: Tue, 25 Apr 2006 12:44:07 -0700
From: Greg KH <gregkh@suse.de>
To: Brian Uhrain <buhrain@rosettastone.com>,
       Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.6 ( - 2.6.16.11 ) compile failure on an alpha
Message-ID: <20060425194407.GA23288@suse.de>
References: <20060425101647.GH4349@vega.lnet.lut.fi> <444DFA05.2060508@rosettastone.com> <20060425185340.GH25520@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425185340.GH25520@lug-owl.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 08:53:40PM +0200, Jan-Benedict Glaw wrote:
> On Tue, 2006-04-25 11:29:25 +0100, Brian Uhrain <buhrain@rosettastone.com> wrote:
> > ---
> >  arch/alpha/kernel/setup.c |   12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > --- linux-2.6.16.11.orig/arch/alpha/kernel/setup.c	2006-04-25 11:21:03.000000000 +0100
> > +++ linux-2.6.16.11/arch/alpha/kernel/setup.c	2006-04-25 11:22:56.557266608 +0100
> > @@ -483,11 +483,13 @@ register_cpus(void)
> >  {
> >  	int i;
> >  
> > -	for_each_possible_cpu(i) {
> > -		struct cpu *p = kzalloc(sizeof(*p), GFP_KERNEL);
> > -		if (!p)
> > -			return -ENOMEM;
> > -		register_cpu(p, i, NULL);
> > +	for (i = 0; i < NR_CPUS; i++) {
> 
> Nope.  Please implement for_each_possible_cpu(). A patch for that flew
> along right today.

Yes, that's the proper patch.  It's in my queue to add it to the -stable
queue :)

thanks,

greg k-h
