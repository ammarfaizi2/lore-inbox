Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVADQ3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVADQ3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVADQYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:24:53 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:17245 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261715AbVADQXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:23:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jq2M93sKwAsmfeMsw5LBm+DCwUgnPCrtzKDs/vebo+yZHZIrHrtzjC6paLeYzEflGh7mRWSx7gjYzz0yDhn8SAXbLaElAgl6ORAXf6axHDlU+N+bMn3E/LTO7FHbQYZctvdCfUBML2lNqhlVbVlfEKU8q6i9orkGlg++vSWOCzc=
Message-ID: <d120d50005010408232e29661@mail.gmail.com>
Date: Tue, 4 Jan 2005 11:23:40 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [bk patches] Long delayed input update
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58.0501040812420.2294@ppc970.osdl.org>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005 08:14:52 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Tue, 4 Jan 2005, Vojtech Pavlik wrote:
> >
> > I can hide it, the reasoning was that it may be useful for out-of-kernel
> > modules, and because of that it's possible to enable it even when there
> > are no users, and only then it's an option.
> >
> > atkbd and psmouse do "select" it.
> 
> Ok, that seems fine. I'll hide it behind "EMBEDDED" at least until
> somebody actually has an out-of-tree user on any platform where it makes
> any sense (on a PC it will be enabled _anyway_ by the kbd/mouse thing, and
> on anything else I don't see it making any sense anyway, and it clearly
> only confuses people - since it confused me).
> 

i8042-style ports are not limited to PC - maceps2.c, q40kbd.c,
rpckbd.c and sa1111ps2.c also implement them that's why libps2 wasn't
limited to x86 arch.

-- 
Dmitry
