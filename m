Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262982AbSJBGGs>; Wed, 2 Oct 2002 02:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262983AbSJBGGs>; Wed, 2 Oct 2002 02:06:48 -0400
Received: from packet.digeo.com ([12.110.80.53]:48121 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262982AbSJBGGr>;
	Wed, 2 Oct 2002 02:06:47 -0400
Message-ID: <3D9A8E34.7BC5E91A@digeo.com>
Date: Tue, 01 Oct 2002 23:12:04 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: input layer strangeness
References: <3D9A74CF.8C8585E7@digeo.com> <20021002080952.B17477@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2002 06:12:05.0937 (UTC) FILETIME=[A1DFA210:01C269DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Tue, Oct 01, 2002 at 09:23:43PM -0700, Andrew Morton wrote:
> >
> > It's been doing this ever since the input layer changes:
> >
> > - open a few xterms
> > - press the spacebar, leave pressed
> > - start waggling the mouse about
> > - stop pressing spacebar, keep waggling the mouse about,
> >   across the xterms
> >
> > The keystrokes *never* stop coming.  Just the continuous mouse
> > activity causes a stream of keyboard input, at seemingly the normal
> > autorepeat rate. I can keep them coming for 30 seconds, just by
> > moving the mouse.
> 
> Do they stop coming when you stop moving the mouse or they don't stop at
> all? The first would be quite interesting, the second would probably be
> a missed key release event due to keyboard controller overload by the
> mouse.

They stop immediately if I stop moving the mouse.

> > In practice, it's irritating because it's quite easy to get a
> > stream of erroneous input dumped into the wrong windows.
> >
> > It's a vanilla dual pentium with an AT keyboard and a PS/2
> > mouse.
> 
> Can you check if it happens also on UP? Just want to know if it might be
> a SMP issue ...

Will do.
