Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbUDPPdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUDPP3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:29:44 -0400
Received: from tag.witbe.net ([81.88.96.48]:36877 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263364AbUDPP0T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:26:19 -0400
Message-Id: <200404161526.i3GFQI119646@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <rol@as2917.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.5] agp_backend_initialize() failed
Date: Fri, 16 Apr 2004 17:26:15 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQjxqRMT/HMRxuETYSLU8vjoTUfpAAAHM6w
In-Reply-To: <200404161522.i3GFMa118998@tag.witbe.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more logs :

[root@donald log]# egrep "(Linux version|agp)" messages.1
Apr  4 19:38:22 donald kernel: Linux version 2.6.4 (root@donald.as2917.net)
(gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #2 Tue Mar 23 22:02:26
CET 2004
Apr  4 19:38:24 donald kernel: Linux agpgart interface v0.100 (c) Dave Jones
Apr  4 19:38:24 donald kernel: agpgart: Detected SiS 648 chipset
Apr  4 19:38:24 donald kernel: agpgart: Maximum main memory to use for agp
memory: 1430M
Apr  4 19:38:24 donald kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Apr  4 19:40:24 donald kernel: Linux version 2.6.5 (root@donald.as2917.net)
(gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Sun Apr 4 11:49:45
CEST 2004
Apr  4 19:40:26 donald kernel: Linux agpgart interface v0.100 (c) Dave Jones
Apr  4 19:40:26 donald kernel: agpgart: Detected SiS 648 chipset
Apr  4 19:40:26 donald kernel: agpgart: Maximum main memory to use for agp
memory: 1430M
Apr  4 19:40:26 donald kernel: agpgart: unable to determine aperture size.
Apr  4 19:40:26 donald kernel: agpgart: agp_backend_initialize() failed.
Apr  4 19:40:26 donald kernel: agpgart-sis: probe of 0000:00:00.0 failed
with error -22
Apr  8 06:14:59 donald kernel: Linux version 2.6.5 (root@donald.as2917.net)
(gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Sun Apr 4 11:49:45
CEST 2004
Apr  8 06:15:01 donald kernel: Linux agpgart interface v0.100 (c) Dave Jones
Apr  8 06:15:01 donald kernel: agpgart: Detected SiS 648 chipset
Apr  8 06:15:01 donald kernel: agpgart: Maximum main memory to use for agp
memory: 1430M
Apr  8 06:15:01 donald kernel: agpgart: unable to determine aperture size.
Apr  8 06:15:01 donald kernel: agpgart: agp_backend_initialize() failed.
Apr  8 06:15:01 donald kernel: agpgart-sis: probe of 0000:00:00.0 failed
with error -22
Apr 10 07:24:10 donald kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
Apr 10 07:24:10 donald kernel: agpgart: Maximum main memory to use for agp
memory: 816M
Apr 10 07:24:10 donald kernel: agpgart: Detected SiS 648 chipset
Apr 10 07:24:10 donald kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Apr 12 22:11:31 donald kernel: Linux version 2.6.5 (root@donald.as2917.net)
(gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Sun Apr 4 11:49:45
CEST 2004
Apr 12 22:11:33 donald kernel: Linux agpgart interface v0.100 (c) Dave Jones
Apr 12 22:11:33 donald kernel: agpgart: Detected SiS 648 chipset
Apr 12 22:11:33 donald kernel: agpgart: Maximum main memory to use for agp
memory: 1430M
Apr 12 22:11:33 donald kernel: agpgart: unable to determine aperture size.
Apr 12 22:11:33 donald kernel: agpgart: agp_backend_initialize() failed.
Apr 12 22:11:33 donald kernel: agpgart-sis: probe of 0000:00:00.0 failed
with error -22

It seems it is related to agpgart interface v0.100...

Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 

  

> -----Message d'origine-----
> De : Paul Rolland [mailto:rol@as2917.net] 
> Envoyé : vendredi 16 avril 2004 17:23
> À : linux-kernel@vger.kernel.org
> Cc : rol@as2917.net
> Objet : [2.6.5] agp_backend_initialize() failed
> 
> Hello,
> 
> I juste realized that my messages log contains :
> 
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected SiS 648 chipset
> agpgart: Maximum main memory to use for agp memory: 1430M
> agpgart: unable to determine aperture size.
> agpgart: agp_backend_initialize() failed.
> agpgart-sis: probe of 0000:00:00.0 failed with error -22
> 
> Before, I had :
> 
> Mar 23 22:09:12 donald kernel: Linux agpgart interface v0.100 
> (c) Dave Jones
> Mar 23 22:09:12 donald kernel: agpgart: Detected SiS 648 chipset
> Mar 23 22:09:12 donald kernel: agpgart: Maximum main memory 
> to use for agp
> memo
> ry: 1430M
> Mar 23 22:09:12 donald kernel: agpgart: AGP aperture is 256M 
> @ 0xd0000000
> Mar 23 22:09:12 donald kernel: [drm] Initialized radeon 1.9.0 
> 20020828 on
> minor
>  0
> 
> with kernel 2.6.4 :
> 
> Mar 23 22:09:10 donald kernel: Linux version 2.6.4 
> (root@donald.as2917.net)
> (gc
> c version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #2 Tue Mar 
> 23 22:02:26 CET
> 20
> 04
> 
> Any hint ? I can't remember reading anything about that in lkml...
> 
> Regards,
> Paul
> rol@as2917.net
> 
> 
> 
> 


