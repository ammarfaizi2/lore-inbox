Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVANOAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVANOAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVANOAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:00:52 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:33933 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261987AbVANN71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 08:59:27 -0500
To: aia21@cam.ac.uk
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.60.0501141327450.18572@hermes-1.csi.cam.ac.uk>
	(message from Anton Altaparmakov on Fri, 14 Jan 2005 13:32:18 +0000
	(GMT))
Subject: Re: [PATCH] FUSE - remove mount_max and user_allow_other module
 parameters
References: <E1CpQvu-0000WV-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.60.0501141327450.18572@hermes-1.csi.cam.ac.uk>
Message-Id: <E1CpRyi-0001bB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Jan 2005 14:59:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure you want to do this?  Placing security checks inside a 
> userspace utility and allowing everyone to do it in the kernel means that 
> any user/hacker could compile their own version of fusermount without the 
> check and bypass your security...  

These checks were part of the mount procedure.  Since currently
mount() is a privileged operation, it makes no difference if the check
is made inside the kernel or in a (secure) suid userspace app.

> So if you really do not want users to be able to do this you must do
> it inside the kernel.

I'd very much prefer a solution, where in certain situations the
privileges required for mount() could be relaxed.  But this involves
more than just a few checks in the FUSE kernel module.

Thanks,
Miklos
