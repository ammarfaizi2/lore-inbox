Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVADQVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVADQVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVADQRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:17:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:16835 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbVADQPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:15:03 -0500
Date: Tue, 4 Jan 2005 08:14:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [bk patches] Long delayed input update
In-Reply-To: <20050104160830.GA13125@ucw.cz>
Message-ID: <Pine.LNX.4.58.0501040812420.2294@ppc970.osdl.org>
References: <20041227142821.GA5309@ucw.cz> <200412271419.46143.dtor_core@ameritech.net>
 <20050103131848.GH26949@ucw.cz> <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
 <20050104135859.GA9167@ucw.cz> <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org>
 <20050104160830.GA13125@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jan 2005, Vojtech Pavlik wrote:
> 
> I can hide it, the reasoning was that it may be useful for out-of-kernel
> modules, and because of that it's possible to enable it even when there
> are no users, and only then it's an option.
> 
> atkbd and psmouse do "select" it.

Ok, that seems fine. I'll hide it behind "EMBEDDED" at least until 
somebody actually has an out-of-tree user on any platform where it makes 
any sense (on a PC it will be enabled _anyway_ by the kbd/mouse thing, and 
on anything else I don't see it making any sense anyway, and it clearly 
only confuses people - since it confused me).

> > So it has been part of the -mm tree? Good.
> 
> Yes.

Ok. I'll re-pull and make it embedded to make that irritating question go 
away.

		Linus
