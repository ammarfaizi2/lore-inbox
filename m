Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272329AbRHXVPS>; Fri, 24 Aug 2001 17:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272330AbRHXVPI>; Fri, 24 Aug 2001 17:15:08 -0400
Received: from std69-limi.telecom.sk ([212.5.197.69]:516 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S272329AbRHXVPD>;
	Fri, 24 Aug 2001 17:15:03 -0400
Date: Mon, 20 Aug 2001 12:15:30 -0400
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8: insmod ipx.o failed
Message-ID: <20010820121530.A2862@boris.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

            Hello.

I decided to try linux ipx support so i compiled ipx as module ipx.o.
The version of kernel i tried is 2.4.8.

.config:
CONFIG_IPX=m

When insmod-ing ipx.o i get following errors:

[root@boris ipx]# insmod ipx.o
ipx.o: unresolved symbol make_EII_client
ipx.o: unresolved symbol make_8023_client
ipx.o: unresolved symbol destroy_8023_client
ipx.o: unresolved symbol destroy_EII_client

I've found following names in /proc/ksyms:

c0194a70 make_8023_client_R__ver_make_8023_client
c0194aa0 destroy_8023_client_R__ver_destroy_8023_client
c0194a00 make_EII_client_R__ver_make_EII_client
c0194a30 destroy_EII_client_R__ver_destroy_EII_client

I would expect checksum values appended as to other names in it.
Other network stuff i use works well now.

Can you help me to show how should i solve this or is there already a patch on 2.4.8 ? If, i'm not subscribed on this list, so please mail me to:

boris@acheron.sk

Thanks                                                           Boris


