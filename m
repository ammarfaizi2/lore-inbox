Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbTDENxB (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTDENxB (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:53:01 -0500
Received: from smtp.terra.es ([213.4.129.129]:6314 "EHLO tsmtp5.mail.isp")
	by vger.kernel.org with ESMTP id S261632AbTDENxA (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 08:53:00 -0500
Date: Sat, 5 Apr 2003 16:04:18 +0200
From: Arador <diegocg@teleline.es>
To: Anup Pemmaiah <pemmaiah@cc.usu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Building Kernel-2.5
Message-Id: <20030405160418.73f3cb0c.diegocg@teleline.es>
In-Reply-To: <3E8FAF07@webmail.usu.edu>
References: <3E8FAF07@webmail.usu.edu>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Apr 2003 18:47:46 -0700
Anup Pemmaiah <pemmaiah@cc.usu.edu> wrote:

Did you enable "virtual terminal" support? (under char devices)
You've to enable the input device support as compiled in the kernel,
not as module.

>  4) "make mrpoper" to remove remains of previous builds

You don't need this now...the kernel builder now is smart enought to know
what has to recompile and what doesn't have.

>  6) "make dep", I know it doesn't help because of no change in default 
> settings

and make dep isn't needed now AFAIK

>  7) "make clean"

The same for this; when you apply a patch; just a "make" will recompile
the files you need; see "make help" for help ;)


> CONFIG_INPUT=m

As I said, this has to be compiled inside the kernel (you also want keyboard
support, right? ;). If you don't compile it; or compile it as
module; the "virtual terminal support" menu entry won't appear for some
reason....

I think that a BIG warning should be added if CONFIG_INPUT isn't compiled

