Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272143AbTHIAYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272144AbTHIAYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:24:32 -0400
Received: from pat.uio.no ([129.240.130.16]:21892 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S272143AbTHIAYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:24:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Timothy Miller <miller@techsource.com>, Jasper Spaans <jasper@vs19.net>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
References: <Pine.LNX.4.44.0308081011550.27922-100000@home.osdl.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 09 Aug 2003 02:24:15 +0200
In-Reply-To: <Pine.LNX.4.44.0308081011550.27922-100000@home.osdl.org>
Message-ID: <shsisp7fzkg.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@osdl.org> writes:

     > On Fri, 8 Aug 2003, Timothy Miller wrote:
    >>
    >> > 1357: rpc_authflavor_t authflavour;

     > This one I think is valid. Considering how many people seem to
     > care, I think we should keep it as the only valid case for now.

Since we appear to be in the silly season...



diff -u --recursive --new-file linux-2.6.0-test2/fs/nfs/inode.c gnurr/fs/nfs/inode.c
--- linux-2.6.0-test2/fs/nfs/inode.c	2003-07-17 19:40:29.000000000 +0200
+++ gnurr/fs/nfs/inode.c	2003-08-09 02:22:12.000000000 +0200
@@ -1354,7 +1354,7 @@
 	struct rpc_xprt *xprt = NULL;
 	struct rpc_clnt *clnt = NULL;
 	struct rpc_timeout timeparms;
-	rpc_authflavor_t authflavour;
+	rpc_authflavour_t authflavour;
 	int proto, err = -EIO;
 
 	sb->s_blocksize_bits = 0;
diff -u --recursive --new-file linux-2.6.0-test2/include/linux/sunrpc/auth.h gnurr/include/linux/sunrpc/auth.h
--- linux-2.6.0-test2/include/linux/sunrpc/auth.h	2003-06-12 04:22:40.000000000 +0200
+++ gnurr/include/linux/sunrpc/auth.h	2003-08-09 02:21:37.000000000 +0200
@@ -138,5 +138,7 @@
 	return cred;
 }
 
+#define rpc_authflavour_t rpc_authflavor_t
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SUNRPC_AUTH_H */
