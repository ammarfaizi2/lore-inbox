Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTHTKy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 06:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbTHTKy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 06:54:27 -0400
Received: from mail.szintezis.hu ([195.56.253.241]:18610 "HELO
	hold.szintezis.hu") by vger.kernel.org with SMTP id S261878AbTHTKyZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 06:54:25 -0400
Subject: Re: 2.6.0-test3-mm3
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1061370505.510.3.camel@sunshine>
References: <20030819013834.1fa487dc.akpm@osdl.org> 
	<1061370505.510.3.camel@sunshine>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 20 Aug 2003 12:54:32 +0200
Message-Id: <1061376873.5331.9.camel@sunshine>
Mime-Version: 1.0
X-OriginalArrivalTime: 20 Aug 2003 10:54:24.0079 (UTC) FILETIME=[6ACE7DF0:01C36709]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2003-08-19, k keltezéssel Andrew Morton ezt írta:

> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm3/
 

> Hi!
> 
> Compile error in drivers/media/video/tvmixer.c
> 
> 
> [...]
> 
>   CC [M]  drivers/media/video/tvmixer.o
> drivers/media/video/tvmixer.c: In function `tvmixer_clients':
> drivers/media/video/tvmixer.c:294: error: structure has no member named
> `name'
> drivers/media/video/tvmixer.c:294: error: structure has no member named
> `name'
> make[3]: *** [drivers/media/video/tvmixer.o] Error 1
> make[2]: *** [drivers/media/video] Error 2
> make[1]: *** [drivers/media] Error 2
> make: *** [drivers] Error 2



---------------------------------------------------------------------------


--- tvmixer.c   2003-08-09 06:40:55.000000000 +0200
+++ tvmixer.c_  2003-08-20 12:41:33.000000000 +0200
@@ -291,7 +291,7 @@
        devices[i].count = 0;
        devices[i].dev   = client;
        printk("tvmixer: %s (%s) registered with minor %d\n",
-              client->dev.name,client->adapter->dev.name,minor);
+              client->name,client->adapter->name,minor);

        return 0;
 }




-- 
Windows not found
(C)heers, (P)arty or (D)ance?
-----------------------------------
Micskó Gábor
Compaq Accredited Platform Specialist, System Engineer (APS, ASE)
Szintézis Computer Rendszerház Rt.      
H-9021 Gyõr, Tihanyi Árpád út 2.
Tel: +36-96-502-216
Fax: +36-96-318-658
E-mail: gmicsko@szintezis.hu
Web: http://www.hup.hu/

