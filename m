Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbUJZP34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbUJZP34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbUJZP34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:29:56 -0400
Received: from sd291.sivit.org ([194.146.225.122]:6805 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262296AbUJZP3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:29:21 -0400
Date: Tue, 26 Oct 2004 17:30:36 +0200
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041026153036.GA4381@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
References: <20041025152029.4788.qmail@web81303.mail.yahoo.com> <20041026092802.GC2998@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026092802.GC2998@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 11:28:02AM +0200, Stelian Pop wrote:

> > [1] 
> > http://csociety-ftp.ecn.purdue.edu/pub/gentoo/distfiles/xorg-x11-6.8.0-patches-0.2.5.tar.bz2
> > Extract patches 9000, 9001 and 9002. Btw, these are not mine - I have
> > Not even tries them myself but I have read several success stories.
> 
> Got them and trying to build the new drivers right now. Thanks !

Well, it kinda works, but there are still some rough edges (the kbd
driver maps all the unknown keys to KEY_UNKNOWN, making them all to
have the same keycode in X, making them unusable. After removing the
test it forwards the events ok).

There are also problems because my sonypi input device acts both like
a mouse and a keyboard, and the X event driver wants them to be separate.

Vojtech: should I generate two different input devices in my driver,
a mouse like and a keyboard like device, or should the userspace be
able to demultiplex the events ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
