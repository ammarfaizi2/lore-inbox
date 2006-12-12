Return-Path: <linux-kernel-owner+w=401wt.eu-S1751513AbWLLQyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWLLQyZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWLLQyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:54:25 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:44248 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbWLLQyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:54:24 -0500
Date: Tue, 12 Dec 2006 10:54:16 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       LKML <linux-kernel@vger.kernel.org>, trevor.highland@gmail.com,
       tyhicks@ou.edu
Subject: Re: [PATCH 1/2] eCryptfs: Public key; transport mechanism
Message-ID: <20061212165416.GA4796@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061206230638.GA9358@us.ibm.com> <20061206215555.85d584ca.akpm@osdl.org> <20061209110416.670170eb.randy.dunlap@oracle.com> <20061209112130.f3ba7f22.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209112130.f3ba7f22.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 11:21:30AM -0800, Andrew Morton wrote:
> On Sat, 9 Dec 2006 11:04:16 -0800
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > > ecryptfs now has a dependency upon netlink.  There's no
> > > CONFIG_NETLINK.  If CONFIG_NET=n && CONFIG_ECRYPTFS=y is
> > > possible, it won't build.
> >
> > Then shouldn't ECRYPTFS depend on CONFIG_NET ?
> 
> yup, that's what I meant..

Add net build dependency to eCryptfs Kconfig entry.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

b2bc2515b6849154a9598bca4975dc721799954c
diff --git a/fs/Kconfig b/fs/Kconfig
index c93d82b..17ae291 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1103,7 +1103,7 @@ config AFFS_FS
 
 config ECRYPT_FS
 	tristate "eCrypt filesystem layer support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && KEYS && CRYPTO
+	depends on EXPERIMENTAL && KEYS && CRYPTO && NET
 	help
 	  Encrypted filesystem that operates on the VFS layer.  See
 	  <file:Documentation/ecryptfs.txt> to learn more about
-- 
1.3.3
