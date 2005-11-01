Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVKAUuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVKAUuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVKAUuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:50:55 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:51676 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751149AbVKAUuy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:50:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HKSTAaCoUBLkV0huwjVZ481whoQucPP4bnyOb1PxB1k2APnni1/X/4iByIeZjssBQvamy+HffYUWSrNzXRLoEdsu09DnLUHjjB/T2XuDg5wRuMv/9gj2R3whFyuUSyrGBGi1a3vRzgdS/jR3fxfflB6zDarnVRljQNgZJyK6HoA=
Message-ID: <d120d5000511011250r423dc1e7w4142b51f587ca6eb@mail.gmail.com>
Date: Tue, 1 Nov 2005 15:50:53 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: after latest input updates, locomo keyboard kills boot
Cc: vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>,
       rpurdie@rpsys.net, lenz@cs.wisc.edu
In-Reply-To: <20051101190556.GD29974@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051101094945.GA7293@elf.ucw.cz>
	 <d120d5000511010712o77b2b1afie52e47ac07b09a8c@mail.gmail.com>
	 <20051101190556.GD29974@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
> > > drivers/input/keyboard/locomokbd.c:
> > >
> > > struct locomokbd {
> > >        unsigned char keycode[LOCOMOKBD_NUMKEYS];
> > >        struct input_dev input;
> > >        ~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > ...and I guess that's the problem. What needs to be done? Just replace
> > > it with struct input_dev *?
> >
> > Try the attached. BTW, shouldn't input->id.bus be BUS_HOST and not
> > >BUS_XTKBD?
>
> Yes, that helped, thanks a lot. Will you take care of merging, or
> should I push it through akpm?

I have couple more patches that I am going to ask Linus to pull (if
Vojtech blesses them).

--
Dmitry
