Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276329AbRJ2Q3w>; Mon, 29 Oct 2001 11:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276312AbRJ2Q3m>; Mon, 29 Oct 2001 11:29:42 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:528 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S276249AbRJ2Q3b>; Mon, 29 Oct 2001 11:29:31 -0500
Message-Id: <200110291629.f9TGTt6K010692@pincoya.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x-ac: No loop on tmpfs
X-Mailer: MH [Version 6.8.4]
Date: Mon, 29 Oct 2001 13:29:55 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know when this started (maybe it has been there forever...), but
you can't losetup(8) a loop device from a file on a tmpfs. [Yes, I _know_
this is an idiotic thing to do. But uniformity is nice...]

Here (Red Hat 7.1 + new kernel + random patches), /tmp is tmpfs, and
mkinitrd(8) won't work for this reason, so kernel upgrades fail.

Any fundamental reason for this behaviour, and should RH just use /var/tmp
or something else? Or is this a simple oversight of some sort?
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
