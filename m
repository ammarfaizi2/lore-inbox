Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbTCIXq3>; Sun, 9 Mar 2003 18:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262671AbTCIXq3>; Sun, 9 Mar 2003 18:46:29 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:40201 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S262670AbTCIXq2>;
	Sun, 9 Mar 2003 18:46:28 -0500
Date: Mon, 10 Mar 2003 00:57:01 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Work around console initialization ordering problem
Message-ID: <20030309235701.GA3854@win.tue.nl>
References: <20030309163242.GA2335@averell> <20030309134506.5809262b.akpm@digeo.com> <20030309233447.GA1701@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309233447.GA1701@averell>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 12:34:47AM +0100, Andi Kleen wrote:
> On Sun, Mar 09, 2003 at 10:45:06PM +0100, Andrew Morton wrote:
> > Andi Kleen <ak@muc.de> wrote:
> > >
> > > 
> > > Works around the console ordering problem in 2.5.64-bk3. Following 
> > > the similar fix I did for x86-64.
> > > ...
> > > +	if (!strstr(saved_command_line, "console="))
> > > +	     strcat(saved_command_line, " console=tty0");
> > > +
> > 
> > We can do it by shuffling the link order:
> 
> Yes, but someone will surely break it again. I feel my low tech solution is 
> less fragile.

But what about COMMAND_LINE_SIZE?

