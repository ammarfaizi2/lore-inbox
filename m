Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293498AbSCASqc>; Fri, 1 Mar 2002 13:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293505AbSCASqW>; Fri, 1 Mar 2002 13:46:22 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:47811 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S293498AbSCASqG>; Fri, 1 Mar 2002 13:46:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Paul W. Abrahams" <abrahams@acm.org>
To: linux-kernel@vger.kernel.org
Subject: Changing processor type causes module load errors, 2.4.17
Date: Fri, 1 Mar 2002 13:45:59 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020301184600.HLLJ2626.rwcrmhc51.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I''m running the 2.4.17 kernel.   If I change the processor type from 586 to 
Athlon-Duron, I get a number of module loading errors.   Unfortunately only 
one of them shows up in /var/log/boot.msg.   Here's the difference:

With Athlon/Duron:

Mar  1 13:18:02 suillus automount[488]: starting automounter version 4.0.0, 
path = /misc, maptype = file, mapname = /etc/auto.misc
Mar  1 13:18:02 suillus automount[490]: starting automounter version 4.0.0, 
path = /net, maptype = program, mapname = /etc/auto.net
Mar  1 13:18:02 suillus insmod: 
/lib/modules/2.4.17/kernel/fs/autofs4/autofs4.o: insmod autofs failed
Mar  1 13:18:02 suillus automount[488]: cannot find autofs in kernel
Mar  1 13:18:02 suillus automount[488]: /misc: mount failed!
Mar  1 13:18:02 suillus insmod: 
/lib/modules/2.4.17/kernel/fs/autofs4/autofs4.o: insmod autofs failed
Mar  1 13:18:02 suillus automount[490]: cannot find autofs in kernel
Mar  1 13:18:02 suillus automount[490]: /net: mount failed!

With 586 (this works):

Mar  1 13:31:55 suillus automount[485]: starting automounter version 4.0.0, 
path = /misc, maptype = file, mapname = /etc/auto.misc
Mar  1 13:31:55 suillus automount[487]: starting automounter version 4.0.0, 
path = /net, maptype = program, mapname = /etc/auto.net
Mar  1 13:31:55 suillus automount[485]: using kernel protocol version 4
Mar  1 13:31:55 suillus automount[485]: using timeout 300 seconds; freq 75 
secs
Mar  1 13:31:55 suillus insmod: insmod: a module named autofs4 already exists
Mar  1 13:31:55 suillus insmod: insmod: insmod autofs failed
Mar  1 13:31:55 suillus automount[487]: using kernel protocol version 4
Mar  1 13:31:55 suillus automount[487]: using timeout 300 seconds; freq 75 
secs

The other errors show up as an inability to load /deb/lp0 and /dev/eth0.   I 
can't be more precise about these errors because I haven't managed to capture 
the messages; I can only try to observe them as they fly by on the opening 
screens.

Paul Abrahams
