Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVCOUQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVCOUQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVCOUOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:14:22 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:35240 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261837AbVCOUJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:09:49 -0500
Date: Tue, 15 Mar 2005 21:10:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: dtor_core@ameritech.net, dmitry.torokhov@gmail.com,
       helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3 mouse oddity
Message-ID: <20050315201038.GA5484@ucw.cz>
References: <20050312034222.12a264c4.akpm@osdl.org> <4236D428.4080403@aitel.hist.no> <d120d50005031506252c64b5d2@mail.gmail.com> <20050315110146.4b0c5431.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315110146.4b0c5431.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 11:01:46AM -0800, Andrew Morton wrote:
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

Mouse device numbers are defined to be unstable because of hotplug.

Most users use /dev/input/mice, where this won't have impact.

The officially correct solution is to use udev to get stable device
names.

The change is easily reverted - just change the 'atkbd.scroll' default
value.

> > Vojtech, is is possible to detect whether a keyboard has scroll
> > wheel(s) by its ID?
> 
> What sort of keyboard has a scroll wheel??

Many today. Microsoft, Logitech, most "office" and "internet" keyboards.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
