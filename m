Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935057AbWLFPNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935057AbWLFPNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934996AbWLFPNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:13:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:17091 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935057AbWLFPNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:13:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HnATeotEa49DrQ+zKY0YzEdYCzKXuWvTOJMd6pprh3RZkJw2qUgudNWoK11ry8xR9j8L2VFNhTdACKtiNtsvI4Y3gI+YlHSm3looyhJKl8PZRQDE63j0911DPTsuQfH4XlvB22QnRnTyvvDU83vDYyDvInYZCOJAfhGgaAayElI=
Message-ID: <d120d5000612060713n5118b379w11dc7e65abae1c58@mail.gmail.com>
Date: Wed, 6 Dec 2006 10:13:15 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jkosina@suse.cz>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
Cc: "Marcel Holtmann" <marcel@holtmann.org>, "Li Yu" <raise.sail@gmail.com>,
       "Greg Kroah Hartman" <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       "Vincent Legoll" <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>
In-Reply-To: <Pine.LNX.4.64.0612061549040.29624@jikos.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612061803324532133@gmail.com>
	 <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
	 <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com>
	 <1165415924.2756.63.camel@localhost>
	 <Pine.LNX.4.64.0612061549040.29624@jikos.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 6 Dec 2006, Marcel Holtmann wrote:
>
> > > I still have the same objection - the "simple'" code will have to be
> > > compiled into the driver instead of being a separate module and
> > > eventyally will lead to a monster-size HID module. We have this issue
> > > with psmouse to a degree but with HID the growth potential is much
> > > bigger IMO.
>
> I guess that this paragraph wasn't for me, but rather for the author of
> the HID Simple Driver proposal, am I right?

Yes, mainly for him but also for you because we need to be able to do
what Li Yu is trying to do and be able to tweak HID interfaces.

...

> This split is quite painful, as there are many things happening in USB all
> the time, so the best way seem to be just to perform big split (with
> needed changes) at once, and then develop other things on top of it (like
> hidraw).

Is there any reason why we can't mecanically move everything into
drivers/hid right now? Then Greg could simply forward all patches he
gets for HID your way and you won't have hard time merging your work
with others...

-- 
Dmitry
