Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRALIG6>; Fri, 12 Jan 2001 03:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRALIGp>; Fri, 12 Jan 2001 03:06:45 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:10435 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129267AbRALIGk>; Fri, 12 Jan 2001 03:06:40 -0500
To: "J . A . Magallon" <jamagallon@able.es>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: Strange umount problem in latest 2.4.0 kernels
In-Reply-To: <UTC200101112234.XAA98877.aeb@ark.cwi.nl>
	<20010112002303.A905@werewolf.able.es>
From: Christoph Rohland <cr@sap.com>
Date: 12 Jan 2001 09:05:53 +0100
In-Reply-To: <20010112002303.A905@werewolf.able.es>
Message-ID: <qwwg0ipi49q.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, jamagallon@able.es wrote:
> Same cam be applied to shm ? Thus kernel Documentation/Changes
> should be changed:
[...]
> 
> none        /dev/shm    shm     defaults    0 0
> 
> to
> 
> shm        /dev/shm    shm     defaults    0 0
> 

Yes, I thought that I changed that :-( I always have the type as
device in my fstab. 

Linus, it is not really crucial, but still could be applied without
breaking anything for sure ;-) 

Greetings
		Christoph

--- 2.4.0/Documentation/Changes Mon Jan  1 19:00:04 2001
+++ linux/Documentation/Changes Fri Jan 12 09:03:35 2001
@@ -121,7 +121,7 @@
 memory. Adding the following line to /etc/fstab should take care of
 things:
 
-none           /dev/shm        shm             defaults        0 0
+shm            /dev/shm        shm             defaults        0 0
 
 Remember to create the directory that you intend to mount shm on if
 necessary (The entry is automagically created if you use devfs). You           
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
