Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUIVSju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUIVSju (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUIVSju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:39:50 -0400
Received: from hera.cwi.nl ([192.16.191.8]:36005 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266619AbUIVSjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:39:46 -0400
Date: Wed, 22 Sep 2004 20:39:38 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040922183938.GA19457@apps.cwi.nl>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <41505AA1.A51DEE50@users.sourceforge.net> <20040921212620.GA15559@apps.cwi.nl> <4151B0DB.A0DA0135@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4151B0DB.A0DA0135@users.sourceforge.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 08:05:31PM +0300, Jari Ruusu wrote:
> > > How about implementing /etc/fstab option parsing code that is compatible
> > > with existing libc /etc/fstab parsing code:
> > >
> > > defaults,noauto,comment=kudzu,rw
> > >                 ^^^^^^^^^^^^^
> > 
> > Is there such libc parsing code? Can you tell me which libc?
> > Which file? Invoked for what function calls?
> 
> man setmntent

I thought you were pointing me at a comment convention.
But as far as I can see there is none today.

If on the other hand the above is the suggestion for a
comment convention, then I like it, but it has the disadvantage
that it takes part of the namespace of filesystem mount options.
My version did not do that.

> Not directly related to above, but you need to release new version of
> util-linux soon anyway.

OK - done.

> You intruduced this type of gems to util-linux-2.12e
>  
>  	close (fd);
> +
> +	if (i) {
> +		ioctl (fd, LOOP_CLR_FD, 0);

A merge error. Thanks! Fixed.

Andries

[PS - you write "type of", vaguely suggesting that you could
point out more flaws. If you can, please do.]
