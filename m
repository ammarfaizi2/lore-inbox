Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbVBDO1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbVBDO1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbVBDO1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:27:52 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:9440 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263772AbVBDO1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:27:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=o0m9PytFAgKUprV1+MqTZM2643ugFyMNxfoTl+7o+tVvqYjbsNheW3kltlhc/Hqc3mOYu1fT0IarZ8A4AxhBgXC71otOKJdZzCpC4rO0OKUU6WkP2SN5boOMH7kNeUcMmMxoQtCClBkkTU/hyRl3JaF8wAfE+tpFyDzBt+AFtQM=
Message-ID: <d120d50005020406274bc0d847@mail.gmail.com>
Date: Fri, 4 Feb 2005 09:27:44 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0502041511540.6118@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home>
	 <200501292307.55193.dtor_core@ameritech.net>
	 <Pine.LNX.4.61.0501301639171.30794@scrub.home>
	 <200501301839.37548.dtor_core@ameritech.net>
	 <20050204131436.GC10424@ucw.cz>
	 <Pine.LNX.4.61.0502041511540.6118@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 15:13:31 +0100 (CET), Roman Zippel
<zippel@linux-m68k.org> wrote:
> Hi,
> 
> On Fri, 4 Feb 2005, Vojtech Pavlik wrote:
> 
> > > When I go into a menu I explore option and submenus from top to bottom.
> > > So I will see PS/2 or serial, and will go there and select what I need.
> > > Then I will see that generic input layer is also needed for keyboard
> > > and go there.
> > >
> > > If generic layer is first one I select options I think are needed I could
> > > skip over the HW I/O ports thinking that I already selected everything I
> > > need as far as keyboard/mouse goes.
> > >
> > > Does this make any sense?
> >
> > Dmitry, will you make a patch that has the port options first? If no,
> > I'll likely merge Roman's patch.
> 
> I don't think that putting this first is a good idea, compare it to scsi
> or alsa, which also have the generic options first and then the lowlevel
> drivers.
> 

The "generic input layer" submenu is comparable to SCSI or ALSA and
has similar menu structure with userland interfaces on top and drivers
below them. Hardware ports (serio, gameport) "live" outside of generic
input layer and are shown there so they are easier to find.

-- 
Dmitry
