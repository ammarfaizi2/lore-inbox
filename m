Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTKGWdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTKGW1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:27:04 -0500
Received: from zeus.kernel.org ([204.152.189.113]:15062 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264652AbTKGV7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 16:59:35 -0500
Date: Fri, 7 Nov 2003 22:36:11 +0100
From: Jean Delvare <khali@linux-fr.org>
To: DI Dr Simon Vogl <simon@voxel.at>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: I2C parallel port adapters drivers
Message-Id: <20031107223611.173c82cc.khali@linux-fr.org>
In-Reply-To: <3FAB6A8C.9070608@voxel.at>
References: <20031102132342.79920c6f.khali@linux-fr.org>
	<3FAB6A8C.9070608@voxel.at>
Reply-To: sensors@Stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hi,
> sorry for the late answer.

No problem. After all, you're the first one to answer, too ;)

> you're right, the drivers are very similar, and typically you will
> only use one of them. It is of course possible to integrate them all
> into one physical module, which you are free to do :) This is more or
> less grounded on historic reasons far back in the development of the
> driver where I introduced the different hardware access
> implementations to accomodate the different implementations (and this
> went eventually into the kernel...).
> 
> So I'd say, go ahead and code :)

OK, I'll write a unified driver then. Just one more question. Any reason
to prefer direct I/O access (ELV/Velleman) over parallel-port-style
programming (i2c-philips-par)? I'd say that the second is preferable,
but you might have had a reason to use direct access, that I ignore. If
not, I'll somehow use i2c-philips-par as a base for my unified driver,
which I'll probably call i2c-parport (since it won't be Philips-specific
anymore). That driver would support Philips adapters, ELV, Velleman and
ADM evaluation boards (I have one here for testing).

Thanks a lot for spending some time replying.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
