Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUKPTJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUKPTJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUKPTJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:09:37 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:46303 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262097AbUKPTJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:09:22 -0500
To: greg@kroah.com
CC: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20041116175857.GA9213@kroah.com> (message from Greg KH on Tue,
	16 Nov 2004 09:58:57 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com> <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu> <20041116175857.GA9213@kroah.com>
Message-Id: <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 20:09:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So if I only need a single device number should I register a "misc"
> > device?  misc_register() seems to create the relevant sysfs entry.
> 
> Yes, that is a good way to get a device, without having to reserve a
> number.

No, I think reserving a number is still necessary: there seems to be
only a very small space for dynamically registered misc devices (max
15), so that's not any better than reserving a static one.

I just don't yet see the big picture WRT device number allocation.

So what I'm interested in, is if I get a reserved minor number for the
misc (major=10) device, will I be kicked in the butt (by Linus or
anybody else) like for the /proc approach?

Thanks
Miklos
