Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVERNlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVERNlC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVERNlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:41:02 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:9885 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262185AbVERNkC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:40:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dM77gZHizfMSyj/tcfPnSstGtQQ/mdMbYMkLoAxGAKoyTxqCIJdDpwQjLy2NMXOoOevS72fP2Fx7644CK2u8Q0ukgchNSKZwg9cLbH3iFJ+mURyuB9Sixb1kSIHkoJEknUG5Xfy5LNUVeezU/FDTSnHZppRvVycfW80Nh1704BY=
Message-ID: <d120d500050518063926943e91@mail.gmail.com>
Date: Wed, 18 May 2005 08:39:58 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Problem report: 2.6.12-rc4 ps2 keyboard being misdetected as /dev/input/mouse0
Cc: Kris Karas <ktk@enterprise.bidmc.harvard.edu>,
       linux-kernel@vger.kernel.org, Greg Stark <gsstark@mit.edu>
In-Reply-To: <20050518111322.GC1952@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87zmuveoty.fsf@stark.xeocode.com>
	 <200505160036.30628.dtor_core@ameritech.net>
	 <4289682B.8060403@enterprise.bidmc.harvard.edu>
	 <200505162358.15099.dtor_core@ameritech.net>
	 <20050518111322.GC1952@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/05, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > > >>I just updated to 2.6.12-rc4 and now /dev/input/mouse0 seems to be my ps2
> > > >>keyboard.
> > > >>
> > > >Please use /dev/input/mice for accessing your mouse.
> > > >
> > >
> > > One possibly interesting mouse issue in 2.6.12-rc[1..4] is that when
> > > using /dev/psaux, I have found that my mouse cursor under GPM seems to
> > > be triggered into un-hiding when I issue some random number of
> > > non-hiding key-down events.  That is, press and release the keyboard
> > > shift key say 3 or 5 or 10 times, and the console mouse cursor will
> > > appear, just as if the mouse had been moved.  This bug is not in 2.6.11
> > > (nor Alan's 2.6.11-ac7, fwiw).
> > >
> >
> > This is caused by atkbd's scrolling support + GPM not expecting to see a
> > 0-motion packets from devices... I'd say we need to fix GPM not to set
> > GPM_MOVE in these cases; I have looked into adjusting mousedev but it is
> > too ugly for words to suppress them there.
> >
> > Although... maybe the patch below is not too ugly.
> 
> Looks pretty much okay to me...

Hi Pavel,

Does it work for you? If so I'll send it to Andrew to simmer in -mm.

-- 
Dmitry
