Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129800AbQLJJvY>; Sun, 10 Dec 2000 04:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129960AbQLJJvD>; Sun, 10 Dec 2000 04:51:03 -0500
Received: from w064.z064001255.sjc-ca.dsl.cnc.net ([64.1.255.64]:9734 "HELO
	pop.mountainviewdata.com") by vger.kernel.org with SMTP
	id <S129800AbQLJJux>; Sun, 10 Dec 2000 04:50:53 -0500
From: "Peter Braam" <braam@mountainviewdata.com>
To: <linux-kernel@vger.kernel.org>
Subject: InterMezzo FS beta 0.93 available
Date: Sun, 10 Dec 2000 01:23:14 -0800
Message-ID: <NEBBIIJKCMJGDLNAMBCBKEFACCAA.braam@mountainviewdata.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-BeenThere: intermezzo-announce@lists.sourceforge.net
X-Mailman-Version: 2.0beta5
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


InterMezzo is a high availability file system featuring write back caching
and disconnected operation.  It replicates file trees across multiple
systems, one of the systems plays the role of server, the others are
clients.  InterMezzo recovers from network and server
failures.  InterMezzo shares many ideas with Coda but is considerably
simpler and less fully featured. 

You can find packages and source for beta 0.93 Linux 2.2 kernels in:
ftp://ftp.inter-mezzo.org/pub/intermezzo

Documentation is available on the InterMezzo WWW site:
http://www.inter-mezzo.org

Mailing lists with announcements, discussions etc. are available at:
http://www.sourceforge.net/projects/intermezzo

Sources for cutting edge versions are available from 
http://www.sourceforge.net/projects/intermezzo

New since the previous release:

 - We have migrated to "stock" POE from CPAN
 - Considerable simplification of reconnection code
 - Minor improvements and feature additions to the kernel code
 - RPM packages
 - Minor documentation updates
 - Improvements to the config tools

To reach 1.0 we have the following outstanding issues:
 - Move forward to ext3 0.05c or later
 - Better documentation
 - Conflict detection
 - Bug fixes

Particular thanks go to Shirish Phatak from Tacitus Systems
(shirish@tacitussystems.com) for very persistent debugging and testing.  
Gord Matzigkeit (gord@fig.org) has build the RPM packages and cleaned up
the build environment for this purpose.  Many others have contributed
significantly.


- Peter Braam - 
Mountain View Data, Inc. 



NOTE:

InterMezzo relies on journal file systems for recovery.  This release
works with Ext3 and you must compile 0.03b into your kernel, as well as
the following 3 lines to be add in linux/kernel/ksyms.c:

#include <linux/jfs.h>

EXPORT_KSYM(journal-start);
EXPORT_KSYM(journal_stop); 






_______________________________________________
intermezzo-announce mailing list
intermezzo-announce@lists.sourceforge.net
http://lists.sourceforge.net/mailman/listinfo/intermezzo-announce

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
