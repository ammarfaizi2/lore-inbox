Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131150AbRAJAi1>; Tue, 9 Jan 2001 19:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131785AbRAJAiH>; Tue, 9 Jan 2001 19:38:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:12816 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131150AbRAJAh6>;
	Tue, 9 Jan 2001 19:37:58 -0500
Date: Wed, 10 Jan 2001 01:37:55 +0100
From: Hubert Mantel <mantel@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Compatibility issue with 2.2.19pre7
Message-ID: <20010110013755.D13955@suse.de>
Mail-Followup-To: Hubert Mantel <mantel@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: SuSE Labs, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.2.16
X-PGP-Key: 1024D/B0DFF780, 1024R/CB848DFD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

is this part of 2.2.19pre7 really a good idea? Even in 2.4.0 the size
field is still a short.
                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pre-patch-2.2.19-7"

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/linux/nfs.h linux.19p7/include/linux/nfs.h
--- linux.vanilla/include/linux/nfs.h	Mon Dec 11 22:13:07 2000
+++ linux.19p7/include/linux/nfs.h	Wed Jan  3 00:58:38 2001
@@ -94,7 +94,7 @@
  */
 #define NFS_MAXFHSIZE		64
 struct nfs_fh {
-	unsigned short		size;
+	unsigned int		size;
 	unsigned char		data[NFS_MAXFHSIZE];
 };
 

--FL5UXtIhxfXey3p5--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
