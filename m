Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbTCRDCv>; Mon, 17 Mar 2003 22:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbTCRDCv>; Mon, 17 Mar 2003 22:02:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:49738 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262120AbTCRDCu>;
	Mon, 17 Mar 2003 22:02:50 -0500
Message-Id: <5.2.0.9.2.20030318041526.0258cec8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 18 Mar 2003 04:18:20 +0100
To: "Marijn Kruisselbrink" <marijnk@gmx.co.uk>
From: Mike Galbraith <efault@gmx.de>
Subject: RE: (2.5.65) Unresolved symbols in modules?
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <HJEOKOJLKINBOCDGFDOOOEOACCAA.marijnk@gmx.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:11 AM 3/18/2003 +0100, Marijn Kruisselbrink wrote:
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.65; fi
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.5.65/kernel/drivers/char/lp.ko
> > depmod:         parport_read
> > depmod:         parport_set_timeout
> > depmod:         parport_unregister_device
> > ...
> > [lots and lots of unresolved symbols in lots of modules]
> >
> > What am I doing wrong?  What web page or kernel documentation should I
> > be reading?
>I experienced exactly the same problems when I was running 2.5 kernels for
>the first time. I think the problem is that the module-init-tools are
>installed in /usr/local/sbin instead of /sbin. In /sbin are still the ol
>dmodutils. When you simply run depmod, you will run the module-init-tools,
>but in the linux-makefile /sbin/depmod is called. You could simply copy the
>modutils to *.old (depmod -> depmod.old), and make symlinks/copys of the
>module-init-tools in /sbin (or just make sure make isntall installs them
>there).

./configure --prefix=/usr --bindir=/bin --sbindir=/sbin 

