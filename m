Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271362AbTGWWVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271363AbTGWWVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:21:00 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:239 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271362AbTGWWU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:20:58 -0400
Subject: Re: KERN_ERR "ide: late registration of driver."
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307240100390.17172-100000@marcellos.corky.net>
References: <Pine.LNX.4.44.0307240100390.17172-100000@marcellos.corky.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058999419.6891.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 23:30:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 23:14, Yoav Weiss wrote:
> Recently installed 2.4.22-pre7 on 2 boxes here.
> Seems like drivers_run is already set by the time ide_register_driver get
> called.  Following the logic of that driver, it makes sense.  ide_init()
> gets called early and inits the ide.  (banner: "Uniform Multi-Platform
> E-IDE driver...").  ide_register_driver() is never used inside the driver
> but is exported and called after partition check, way down the line.
> 
> Therefore, I don't see why the late registration is an error.  Am I
> missing something ?

It may change drive ordering. I've not decided if its an error yet but
its on my todo list to fix it one way or the other. I have a hack fix I
can give marcelo for 2.4.22 so its not critical path

