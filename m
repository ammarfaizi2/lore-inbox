Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWATRnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWATRnO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWATRnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:43:14 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:56857 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751117AbWATRnN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:43:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OXG6XLzxUjaN16Mn44d1KBlR49meHFTGNTlRUxsLA7n8cIKSHiyfAHL8xTAekGP6crEjUxfD+PQJfODXHzIak00ukV0JCbZlCz09hhKayXiDvylloRn67271v3IRuA9DtjqHrp92QSVmURcL1I4diG40sxKMQWggbhHpUYpyULg=
Message-ID: <d120d5000601200943o200b3452yff84151b0d495774@mail.gmail.com>
Date: Fri, 20 Jan 2006 12:43:12 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: Development tree, PLEASE?
Cc: Michael Loftis <mloftis@wgops.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060120172431.GE5873@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	 <20060120155919.GA5873@stiffy.osknowledge.org>
	 <d120d5000601200840o704af2e5h6d9087b62594bbe1@mail.gmail.com>
	 <20060120164827.GD5873@stiffy.osknowledge.org>
	 <d120d5000601200855y7318e708va22a21607cf9c078@mail.gmail.com>
	 <20060120172431.GE5873@stiffy.osknowledge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Marc Koschewski <marc@osknowledge.org> wrote:
> * Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-20 11:55:38 -0500]:
>
> > On 1/20/06, Marc Koschewski <marc@osknowledge.org> wrote:
> > > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-20 > >
> > > > Marc, have you tried 2.6.16-rc1 yet? Does it also give you problems
> > > > with psmouse?
> > > >
> > >
> > > Not yet, Dmitry. I just managed to get today's -git compiled and running. I'll
> > > give it a try tonite.
> > >
> > > Moreover, I put a
> > >
> > >        echo -n 0 > /sys/bus/serio/devices/serio0/resync_time
> > >
> > > in my initscripts. Since then I didn't see any problem. I'll report later how it
> > > went with that line removed and stock 2.6.16-rc1.
> > >
> >
> > Ok, if psmouse gives you a fit and setting resync_time to 0 cures it,
> > please do the follwing:
> >
> > echo -n 5 > /sys/bus/serio/devices/serioX/resync_time
> > echo 1 > /sys/modules/i8042/parameters/debug
> > ... wait 10 seconds ...
> > move the mouse slightly
> > ... wait another 10 seconds ...
> > move the mouse slighty again
> > echo 0 > /sys/modules/i8042/parameters/debug
> >
> > and send me your dmesg (or better /var/log/messages or whatever file
> > you use for kernel messages).
> >
> > --
> > Dmitry
>
> OK, here goes:
>

Hmm, I see 2 perfectly healthy resyncs. Could you remind me what is
exactly wrong with the mouse on your box? Does it give you fits right
now (you seem to leave resync on)?

--
Dmitry
