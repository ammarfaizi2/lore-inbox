Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVHIDLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVHIDLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 23:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVHIDLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 23:11:02 -0400
Received: from pop-cowbird.atl.sa.earthlink.net ([207.69.195.68]:7086 "EHLO
	pop-cowbird.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S932429AbVHIDLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 23:11:00 -0400
From: Mac Michaels <wmichaels1@earthlink.net>
To: Michael Krufky <mkrufky@linuxtv.org>
Subject: Re: [PATCH] DVB: lgdt330x frontend: some bug fixes & add lgdt3303 support
Date: Mon, 8 Aug 2005 22:10:25 -0500
User-Agent: KMail/1.8.1
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-dvb-maintainer@linuxtv.org
References: <42F6A294.90300@linuxtv.org> <1123504387.17427.9.camel@localhost> <42F75C0D.3030409@linuxtv.org>
In-Reply-To: <42F75C0D.3030409@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508082210.26007.wmichaels1@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not attached to the experimental code. If it goes away 
my feelings will not be hurt. It was put there so I can 
easily tell an early adopter how to make the noise go away.

-- Mac

On Monday 08 August 2005 08:20 am, Michael Krufky wrote:
> Mauro Carvalho Chehab wrote:
> >	This should't be applied to 2.6.13. It does contain a
> > hack at V4L code, since mute_tda9887 is implemented
> > outside tda9887.c module and could potentially cause
> > troubles since there are some work to provide it on a
> > correct way.
> >	 It should be applied to -mm and go to mainstream only
> > after provided a correct implementation.
> >
> >Mkrufky,
> >	Please avoid trying to submit yet experimental patches
> > to mainstream.
> >
> >Mauro.
>
> Mauro-
>
> Please calm down... This is a newer version of the
> frontend module.  It is DVB code, not v4l.  The new
> frontend module contains the MUTE_TDA9887 hack, however,
> the code is disabled.  The new DVB frontend module has
> some bugfixes.  This is NOT experimental code.  It has
> been testing in cvs for the past month and Mac and I have
> verified that this code works, and is a significant
> improvement over current lgdt330x code in -linus tree.  I
> did NOT send the v4l stuff to Andrew.  FusionHDTV5 Gold
> DVB mode is still disabled in cx88-cards.c.  THIS UPDATE
> IS A BUGFIX.
>
> Mac and I have been testing this new frontend module for
> the past few weeks.  After Mac's latest changes to the
> lgdt330x module, it is now ready to go upstream.  This
> module provides better quality digital tv reception, and
> adds support for LGDT3303.  There is no reason this
> cannot go to 2.6.13.  It is Andrew's choice of whether he
> wishes to fwd to Linus or not.
>
> The tda9887 stuff is disabled inside the code with
> #ifdefs.
>
> Mauro, please do not intercept my patches to Andrew about
> DVB stuff.  I have not kept you informed about Mac's DVB
> stuff because you are v4l maintainer. (not dvb
> maintainer).  Mac and I have worked very hard on this. 
> Most of our correspondence have been short little emails
> and we have been communicating in pvt emails, rather than
> using the list. These patches for the new lgdt330x have
> been tested by many DViCO users, using the
> cvs-tree-merging scripts.   I have discussed these code
> changes with Johannes, and he is happy for me to handle
> the hybrid patches like this.  It is very important that
> the changes made to the lgdt330x module be countered by
> equivalent changes in cx88-dvb.c
>
> Once again, this is NOT an "experimental patch," and THIS
> is the correct implementation for lgdt330x stuff..... 
> The tda9887 stuff can be removed later on.  It is
> harmless right now, as the tda9887 code is disabled by
> ifdefs anyway.  It would be best for the new lgdt330x
> module to be merged into 2.6.13, because the interface is
> no longer compatable with older lgdt330x interface.
>
> Thank you.
