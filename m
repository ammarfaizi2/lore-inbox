Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVCGHar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVCGHar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 02:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVCGHak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 02:30:40 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:1515 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261672AbVCGH36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 02:29:58 -0500
Date: Mon, 7 Mar 2005 08:30:41 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Benoit Boissinot <bboissin@gmail.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: New ALPS code in -mm
Message-ID: <20050307073041.GA1956@ucw.cz>
References: <20050304211327.GA5636@ucw.cz> <Pine.LNX.4.21.0503070204040.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0503070204040.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 02:14:17AM -0500, Daniel Barkalow wrote:

> On Fri, 4 Mar 2005, Vojtech Pavlik wrote:
> 
> >  		/* Relative movement packet */
> >   		if (z == 127) {
> > -			input_report_rel(dev2, REL_X,  (x > 383 ? x : (x - 768)));
> > -			input_report_rel(dev2, REL_Y, -(y > 255 ? y : (x - 512)));
> > +			input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
> > +			input_report_rel(dev2, REL_Y, -(y > 255 ? (x - 512) : y));
> 
> Not that I have any idea, but (y - 512) seems much more likely here.
> 
> > +	if ((priv->i->flags & ALPS_DUALPOINT) && z == 127) {
> > +		input_report_key(dev2, BTN_LEFT,   left);    
> > +		input_report_key(dev2, BTN_RIGHT,  right);
> > +		input_report_key(dev2, BTN_MIDDLE, middle);
> > +		input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
> > +		input_report_rel(dev2, REL_Y, -(y > 255 ? (x - 512) : y));
> 
> Also here.
 
Indeed. It took me a while to find it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
