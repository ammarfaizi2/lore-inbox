Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbUKPKUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUKPKUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUKPKUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:20:33 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:26251 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261368AbUKPKU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 05:20:28 -0500
To: penberg@gmail.com
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <84144f0204111602136a9bbded@mail.gmail.com> (message from Pekka
	Enberg on Tue, 16 Nov 2004 12:13:29 +0200)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com>
Message-Id: <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 11:20:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    - Breaks if CONFIG_PROC_FS is not enabled.

Yes.  Would a device node be better?  Perhaps.  This way there's no
need to allocate a major/minor for a device.

>    - Explicit casts are not needed when converting void pointers
> (found in various places).

But they don't hurt either.  At least I can be sure to assign the
right kind of pointer.

Thanks,
Miklos
