Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317649AbSFRWab>; Tue, 18 Jun 2002 18:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317650AbSFRWab>; Tue, 18 Jun 2002 18:30:31 -0400
Received: from www.transvirtual.com ([206.14.214.140]:61199 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317649AbSFRWaa>; Tue, 18 Jun 2002 18:30:30 -0400
Date: Tue, 18 Jun 2002 15:30:18 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Paul Mundt <lethal@chaoticdreams.org>
cc: Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.22: FB_VESA - early crash in fbcon_cursor()
In-Reply-To: <20020618104340.A1671@ChaoticDreams.ORG>
Message-ID: <Pine.LNX.4.44.0206181527330.5510-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Jun 18, 2002 at 10:15:08AM -0700, James Simmons wrote:
> > Your right. Alot of people have been bitten by that. Especially since
> > people are so use to manually setting the CFB stuff. Patch applied to BK
> > tree.
> >
> Looks like I was a bit hasty with the patch .. fbcon_accel won't resolve if
> fbcon-accel.c isn't linked in, which in turn won't happen unless
> CONFIG_FBCON_ACCEL is set. Can we just do something like the attached instead
> (in addition to killing the ifdef in fbgen.c..)?

Not just yet. Several fbdev drivers have been converted but a good number
need to ported yet. When we are two thirds of the way done then we can
start building in fbcon-accel.c.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/


