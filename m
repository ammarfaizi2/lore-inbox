Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262683AbTCJAbW>; Sun, 9 Mar 2003 19:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262684AbTCJAbV>; Sun, 9 Mar 2003 19:31:21 -0500
Received: from quattro.sventech.com ([205.252.248.110]:1716 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S262683AbTCJAbV>; Sun, 9 Mar 2003 19:31:21 -0500
Date: Sun, 9 Mar 2003 19:42:01 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Work around console initialization ordering problem
Message-ID: <20030309194201.Z9163@sventech.com>
References: <20030309163242.GA2335@averell> <20030309134506.5809262b.akpm@digeo.com> <20030309233447.GA1701@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030309233447.GA1701@averell>; from ak@muc.de on Mon, Mar 10, 2003 at 12:34:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003, Andi Kleen <ak@muc.de> wrote:
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

Wouldn't a well placed comment solve that?

JE

