Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLTTdl>; Wed, 20 Dec 2000 14:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLTTda>; Wed, 20 Dec 2000 14:33:30 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:59660 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129450AbQLTTdQ>; Wed, 20 Dec 2000 14:33:16 -0500
Date: Wed, 20 Dec 2000 22:03:42 +0300
From: Alexander Zarochentcev <zam@namesys.com>
To: linux-kernel@vger.kernel.org
Subject: memmove() in 2.4.0-test12, alpha platform
Message-ID: <20001220220342.B20612@crimson.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

New (since test12) optimized memmove function seems to be broken
on alpha platform. 

If dest and src arguments are misaligned, new memmove does wrong things.


example:
	 
       static char p[] = "abcdefghijklmnopkrstuvwxyz01234567890";
       memmove(p + 2, p + 13, 17);
       printk ("DEBUG: memmove test: %s\n", p);

produces:

       DEBUG: memmove test: abyz0123tuvwxyz0123tuvwxyz01234567890


Old memmove variant didn't have this problem.

Thanks,
Alex.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
