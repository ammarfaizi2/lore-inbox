Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVADR00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVADR00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVADRXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:23:50 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:22803 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261756AbVADRWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:22:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rVExBemb0QxSNgo5iOH9v3NV17iHKlmP1IXhCu/ZuoRj1xGQD6KrM1gjs14x1NCPFIOBRGgOPnMMD5J16nkb4cwJ1fl+ifRxeTeIhSzs4UjlXk1ADAP7SFHPoEq/LWO2oednqlFPk9OtmOLCUX7uvpp1CsHUZG2MeVeu05o8Yuc=
Message-ID: <d120d50005010409223df70973@mail.gmail.com>
Date: Tue, 4 Jan 2005 12:22:17 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [bk patches] Long delayed input update
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20050104164025.GA13240@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041227142821.GA5309@ucw.cz>
	 <200412271419.46143.dtor_core@ameritech.net>
	 <20050103131848.GH26949@ucw.cz>
	 <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
	 <20050104135859.GA9167@ucw.cz>
	 <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org>
	 <20050104160830.GA13125@ucw.cz>
	 <Pine.LNX.4.58.0501040812420.2294@ppc970.osdl.org>
	 <20050104164025.GA13240@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005 17:40:25 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Jan 04, 2005 at 08:14:52AM -0800, Linus Torvalds wrote:
> 
> > Ok. I'll re-pull and make it embedded to make that irritating question go
> > away.
> 
> Thanks.
> 

Ok, now only couple of things were left out:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110430679525030&w=2
08-atkbd-keycode-size.patch
	Fix keycode table size initialization that got broken by my changes
	that exported 'set' and other settings via sysfs.
	setkeycodes should work again now.

http://marc.theaimsgroup.com/?l=linux-kernel&m=110430749420252&w=2
06-ps2pp-mouse-name.patch
	Set mouse name to "Mouse" instead of leaving it NULL when using
	PS2++ protocol and don't have any other information (Wheel, Touchpad)
	about the mouse.

06 is not too critical but without 08 setkeycodes will not work.

In any case I'd like the following patches (01-08, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=110430597110513&w=2) to
be moved forward as they were also staged in -mm tree for over a month
and work fine on my 3 boxes.

-- 
Dmitry
