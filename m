Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWI2JrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWI2JrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWI2JrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:47:11 -0400
Received: from mx1.x-echo.com ([193.252.148.73]:60108 "EHLO smtp1.x-echo.com")
	by vger.kernel.org with ESMTP id S1750821AbWI2JrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:47:10 -0400
Message-ID: <451CEBA8.8050604@lea-linux.com>
Date: Fri, 29 Sep 2006 11:47:20 +0200
From: Tchesmeli Serge <serge@lea-linux.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] ? Strange behaviour since kernel 2.6.17 with a https website
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

First of all, excuse my (poor) english, i'm french.


Me and a friend have discover a stange behaviour since kernel 2.6.17.

Let me explain.
We use to go to a ssh website, our bank website. One day my friend has
notice than he cannot acces this site from his linux workstation, but
can from his windows workstation. On my side, i still access on this
website form my linux workstation. And several days laters i notice i
can access this website too from my workstation, but my linux laptop on
the same network can...
After many tests, we have found that the problem is linked with kernel
version. We don't have the same linux distribution (i'm on slackware
current, he is on a debian unstable), but the same behaviour.
Let see the tests i have made, on the same machine, with two kernel:
2.4.33 and 2.6.17.13:

First test:

darkstar@stchesmeli:~$ uname -a
Linux stchesmeli 2.4.33.3 #1 Fri Sep 1 01:48:52 CDT 2006 i686 pentium4
i386 GNU/Linux

wget --no-check-certificate "https://e.secure.lcl.fr/v_1.0/css/styleAp.css"
--11:17:58--  https://e.secure.lcl.fr/v_1.0/css/styleAp.css
           => `styleAp.css.8'
Resolving e.secure.lcl.fr... 193.110.152.59
Connecting to e.secure.lcl.fr|193.110.152.59|:443... connected.
WARNING: Certificate verification error for e.secure.lcl.fr: unable to
get local issuer certificate
HTTP request sent, awaiting response... 200 OK
Length: 42,745 (42K) [text/css]

100%[==========================================================================================================>]
42,745        --.--K/s            

11:17:58 (476.32 KB/s) - `styleAp.css.8' saved [42745/42745]

--------------- END OF TEST ----------------

wget have take less than 1 second


Second test:
-----------------
darkstar@stchesmeli:~$ uname -a
Linux stchesmeli 2.6.17.11 #1 Fri Sep 1 16:36:50 CEST 2006 i686 pentium4
i386 GN
U/Linux
darkstar@stchesmeli:~$ wget --no-check-certificate
"https://e.secure.lcl.fr/v_1.
0/css/styleAp.css"
--11:44:00--  https://e.secure.lcl.fr/v_1.0/css/styleAp.css
           => `styleAp.css.9'
Resolving e.secure.lcl.fr... 193.110.152.59
Connecting to e.secure.lcl.fr|193.110.152.59|:443... connected.
WARNING: Certificate verification error for e.secure.lcl.fr: unable to
get local
 issuer certificate
HTTP request sent, awaiting response... 200 OK
Length: 42,745 (42K) [text/css]

38%
[==========================================>                                                                      
] 16,384         1.13K/s    ETA 00:22

--------------- END OF TEST ----------------

i have kill wget after 4 mns on the second test.
I have try to change MTU on the interface, no change, same behaviour.



-- 
Tchesmeli serge
Administrateur système & réseau
Expert Linux et Logiciels Libres

