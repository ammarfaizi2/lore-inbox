Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVCOTnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVCOTnB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVCOTlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:41:16 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:29723 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261821AbVCOTew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:34:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=I0ENNDT4n6uJbfQj6H7940YMMJEBduNK2Kgujps8VO2c1BYgzeMx6eeGQBSp6rHxJhToQspeFsAchdgMSSlVJfaY8OsS4pIsv7cImAtsmYacKS0kypM+uBioZYxRV2x+LpwlZoHuEN86VEb7XL6CTlVYsadMKv765RO/rDQ/kfw=
Message-ID: <d120d5000503151134302d741e@mail.gmail.com>
Date: Tue, 15 Mar 2005 14:34:49 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-mm3 mouse oddity
Cc: helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org, vojtech@suse.cz
In-Reply-To: <20050315110146.4b0c5431.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050312034222.12a264c4.akpm@osdl.org>
	 <4236D428.4080403@aitel.hist.no>
	 <d120d50005031506252c64b5d2@mail.gmail.com>
	 <20050315110146.4b0c5431.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 11:01:46 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >
> > On Tue, 15 Mar 2005 13:25:12 +0100, Helge Hafting
> > <helge.hafting@aitel.hist.no> wrote:
> > > 2.6.11-mm1 and earlier: mouse appear as /dev/input/mouse0
> > > 2.6.11-mm3: mouse appear as /dev/input/mouse1
> > >
> > > No big problem, one change to xorg.conf and I got the mouse back.
> > > I guess it wasn't supposed to change like that though?
> > >
> >
> > Vojtech activated scroll handling in keyboard code by default so now
> > your keyboard is mapped to the mouse0 and the mouse moved to mouse1.
> 
> We cannot ship a kernel with this change, surely?  Our users would come
> hunting for us with pitchforks.
>

Not really, athough I was surprised when I noticed that I have extra
mouse devices. I would expect most people using /dev/input/mice which
multiplexes data streams from all mouse-like devices.

I think wacom users will be in for surprise because wacom requres you
to specify exact device name the regular mouse is using. I actually
think wacom X driver shoudl do what Synaptics does and grab evdev
intrface.

> > Vojtech, is it possible to detect whether a keyboard has scroll
> > wheel(s) by its ID?
> 
> What sort of keyboard has a scroll wheel??

Some Microsoft ones IIRC.

-- 
Dmitry
