Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132540AbRDATmD>; Sun, 1 Apr 2001 15:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132541AbRDATlx>; Sun, 1 Apr 2001 15:41:53 -0400
Received: from denise.shiny.it ([194.20.232.1]:19976 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S132540AbRDATlk>;
	Sun, 1 Apr 2001 15:41:40 -0400
Message-ID: <3AC5A16A.9F0147E4@denise.shiny.it>
Date: Sat, 31 Mar 2001 11:20:42 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Temporary disk space leak
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[root@Jay Giu]# du -c /home
[...]
320120	/home
320120	total
[root@Jay Giu]# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda8               253823     65909    174807  27% /
/dev/sda7              2158320    750672   1296240  37% /usr
/dev/sda5              2193082   1898198    183474  91% /home
/dev/sda9              1013887    899924     61586  94% /opt


It happened after I wrote and deleted very large files (~750MB) a
few times in my home dir.
Then I logged out and I relogged in as root to check what happened
and "df" shown everything was right again:

/dev/sda5              2193082    320122   1761550  15% /home


...strange...


Linux Jay 2.4.2 #6 gio mar 22 00:02:30 CET 2001 ppc unknown


Bye.

P.S. Yes, I was the only one using the computer.

