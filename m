Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVDARAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVDARAu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVDARAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:00:50 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:65145 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262790AbVDARAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:00:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DZ6aQBk4qRoxMWLYrmMtzjbrnwjxOdfXoJ3C0OBgzT/8JA5BPACyIzU5nk9f5eBKFuAr+Rz5NAHYbxj06pv0WC/Boue5k796WPl7AFYe3Ssm43C5bNEqv6saFUphyxDfHSlR3QV+KjSwMGCj3f7xMmw5U2LjE0zacqSeTPw3bVg=
Message-ID: <d120d5000504010900142bed75@mail.gmail.com>
Date: Fri, 1 Apr 2005 12:00:42 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Subject: Re: Touchpad does not work anymore
Cc: romano@dea.icai.upco.es, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050401164321.GN10278@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050329110309.GA17744@pern.dea.icai.upco.es>
	 <d120d5000503310715cbc917@mail.gmail.com>
	 <20050331165007.GA29674@pern.dea.icai.upco.es>
	 <200503311309.50165.dtor_core@ameritech.net>
	 <40f323d0050401081423650536@mail.gmail.com>
	 <d120d5000504010828152031a@mail.gmail.com>
	 <20050401164321.GN10278@ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 1, 2005 11:43 AM, Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:
> On Fri, Apr 01, 2005 at 11:28:05AM -0500, Dmitry Torokhov wrote:
> > On Apr 1, 2005 11:14 AM, Benoit Boissinot <bboissin@gmail.com> wrote:
> > > On Mar 31, 2005 8:09 PM, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > > > It works, too. Which one is the best one?
> > > > >
> > > >
> > > > Both of them are needed as they address two different problems.
> > > >
> > > I tried to boot with the 2 patches applied (and the patch which solves
> > > noresume) and now touchpad/touchpoint no longer works (with this
> > > kernel or with an older kernel).
> > >
> >
> > Could you be more explicit - it is not recognized at all or it is
> > recognized but mouse pointer does not move or something else? dmesg
> > also might be interesting.
> >
> It is recognized in dmesg (same message as before), but the mouse
> pointer does not move (a `cat /dev/input/mice` doesn't do anything).
> 

Should work... The patches come into play only when
suspending/resuming. So you are saying even with an old, unpatched
kernel ALS stopped working, right?

Hmm, that USB mouse - was it there before? I wonder if "usb-handoff"
on the kernel comman line will help.

-- 
Dmitry
