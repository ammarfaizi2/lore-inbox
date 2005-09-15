Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbVIOTWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVIOTWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbVIOTWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:22:39 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:36365 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965148AbVIOTWi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:22:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rAjVpbDgM7ZV1uV0wKIp1JcNN9zA8z3Hdt6oJIwsZdglEXzuRIiEJL6Oy/oLMepvOP3bKP2hfOtvBugfMCcW6HTjP/Wrov2ErNozqJ4C8Z88k9FaPSSjshsLD1KwMbaScJ0LuUiU+NXKVm9NqQUKA9KaqqUAJLP8LvpQesQr8bc=
Message-ID: <d120d50005091512226a339890@mail.gmail.com>
Date: Thu, 15 Sep 2005 14:22:34 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch 09/28] Input: convert net/bluetooth to dynamic input_dev allocation
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20050915190700.GA3354@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050915070131.813650000.dtor_core@ameritech.net>
	 <20050915070302.931769000.dtor_core@ameritech.net>
	 <1126770894.28510.10.camel@station6.example.com>
	 <d120d50005091507225659868e@mail.gmail.com>
	 <1126795310.3505.47.camel@station6.example.com>
	 <20050915190700.GA3354@midnight.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Thu, Sep 15, 2005 at 04:41:50PM +0200, Marcel Holtmann wrote:
> > Hi Dmitry,
> >
> > > > > Input: convert net/bluetooth to dynamic input_dev allocation
> > > > >
> > > > > This is required for input_dev sysfs integration
> > > > >
> > > > > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > > >
> > > > on the condition your stuff got merged, then this patch is ok with me.
> > > >
> > > > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > > >
> > >
> > > I was planning on getting patch 8 (preparation patch) into kernel ASAP
> > > and then just sending individual subsystem patches to maintainers and
> > > Andrew so they can merge at their leisure (but don't wait for too long
> > > ;))
> >
> > I have no problem with you submitting the changes. If Vojtech is fine
> > with the proposed way, I would say that we get all of these changes into
> > mainline now. The device model integration is long overdue.
> 
> I'm fine with it, yes. I'm not completely convinced that an input device
> is really a class and not a device. ;) But I can understand that view.

They are devices - class devices :). I have the following distinction
in my head - "normal" devices (bus devices) are real hardware devices
and their drivers need to do resource and/or power management. Class
devices represent virtual devices - some kind of abstraction - that
unify and combine "real" devices from several buses into one class.
And of course nothing shoudl stop us from building class devices on
top of other class devices, if needed.

Anyway, I think if Greg gives up and agrees on nesting classes all of
it can go in -mm for now and I will contact other maintainers to
verify that changes work. IIRC video/dvb mainatiners prefered all
changes to go through them.

In any case I don't expect it reach Linus until after 2.6.14 released
- do you agree?

-- 
Dmitry
