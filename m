Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317941AbSFSRBZ>; Wed, 19 Jun 2002 13:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317942AbSFSRBY>; Wed, 19 Jun 2002 13:01:24 -0400
Received: from pensacola.gci.com ([205.140.80.79]:15109 "EHLO
	pensacola.gci.com") by vger.kernel.org with ESMTP
	id <S317941AbSFSRBW> convert rfc822-to-8bit; Wed, 19 Jun 2002 13:01:22 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA31508EC1070@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.5.22 ide disk hang on boot
Date: Wed, 19 Jun 2002 09:01:16 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki scribed:
> U¿ytkownik leif@denali.net napisa³:
> > I'm having exactly the same issue, with both 2.5.22 and 2.5.23.
> > 
> > I've downloaded the ide-clean-92.diff and applied it 
> > against 2.5.23.  There were some fuzzy offsets, but no rejects.
> >
> You mean you have reverse applied it with the patch -R 
> command of course.

Yes of course. :-)

> Yes 92 is the culprit. I have put it in the change log that
> the unification of the PIO read handlers is dangerous and 
> well indeed it is...

I did have one issue, not sure what it's related to:

My first test was against an SMP compiled kernel running on UP,
as I stated previously.  When re-compiling the kernel, my machine
locked up solid during IDE access.  Unfortunately no magic-keys
were available and I needed to hard-reset and downgrade.

I recompiled for UP, rebooted, and was able to perform multiple
kernel compilations with no hanging.

I didn't perform a stress-test last night, but tonight if i'm able i'll
run some bonnie against it to see if it's stable, if you like.

Leif
