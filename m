Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289293AbSAIJUb>; Wed, 9 Jan 2002 04:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289288AbSAIJUV>; Wed, 9 Jan 2002 04:20:21 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:59042 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289295AbSAIJUJ>; Wed, 9 Jan 2002 04:20:09 -0500
Message-ID: <XFMail.20020109101937.R.Oehler@GDImbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Wed, 09 Jan 2002 10:19:37 +0100 (MET)
From: R.Oehler@GDImbH.com
To: linux-kernel@vger.kernel.org
Subject: Stale NFS handles depending on server-fs-type
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list

currently I got a problem with the userspace-nfs-packet
"nfs-server-2.2beta47".
I'm running the server in multiple-servers-mode (cmd-line
argument to make the server spawn 10 children).
When I export my selfmade filesystem, and do a client-side 
"cp -r /usr/include /net/<server>/export" then the nfs-client 
complains about "stale NFS handles" at about 90% of all files. 
These files appear on the destination-fs, but with  zero-length. 
(Created, but not written-to).

- Local copies to the selfmade filesystem work perfectly.
- When I run the server in single-serverprocess-mode (not 
  spawning children), then it works, too.
- When I use ext2 instead of my selfmade fs, it works, too.

So it appears that the selfmade filesystem does something 
that is OK for linux, but triggers some bug (?) in the 
multiple-server-section of the NFS-server.

Who is the "nfs-server-2.2beta47"-maintainer?
Or who can give me a hint of what could be wrong?

Regards,
        Ralf


 -----------------------------------------------------------------
|  Ralf Oehler
|  GDI - Gesellschaft fuer Digitale Informationstechnik mbH
|
|  E-Mail:      R.Oehler@GDImbH.com
|  Tel.:        +49 6182-9271-23 
|  Fax.:        +49 6182-25035           
|  Mail:        GDI, Bensbruchstraﬂe 11, D-63533 Mainhausen
|  HTTP:        www.GDImbH.com
 -----------------------------------------------------------------

time is a funny concept

