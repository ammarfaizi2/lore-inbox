Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262666AbTCIXYP>; Sun, 9 Mar 2003 18:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbTCIXYP>; Sun, 9 Mar 2003 18:24:15 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:18655 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262666AbTCIXYP>; Sun, 9 Mar 2003 18:24:15 -0500
Date: Mon, 10 Mar 2003 00:34:47 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Work around console initialization ordering problem
Message-ID: <20030309233447.GA1701@averell>
References: <20030309163242.GA2335@averell> <20030309134506.5809262b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309134506.5809262b.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 10:45:06PM +0100, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > 
> > Works around the console ordering problem in 2.5.64-bk3. Following 
> > the similar fix I did for x86-64.
> > ...
> > +	if (!strstr(saved_command_line, "console="))
> > +	     strcat(saved_command_line, " console=tty0");
> > +
> 
> We can do it by shuffling the link order:

Yes, but someone will surely break it again. I feel my low tech solution is 
less fragile.

-Andi

