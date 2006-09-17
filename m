Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWIQBss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWIQBss (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 21:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWIQBsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 21:48:35 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:51909 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932190AbWIQBsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 21:48:07 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 4 of 11] CIFS: Use SEEK_END instead of hardcoded value
X-Mercurial-Node: e2fae9fe7a30bec6e6c2b977e07a06c7eb6eca48
Message-Id: <e2fae9fe7a30bec6e6c2.1158455370@turing.ams.sunysb.edu>
In-Reply-To: <patchbomb.1158455366@turing.ams.sunysb.edu>
Date: Sat, 16 Sep 2006 21:09:30 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
To: linux-kernel@vger.kernel.org
Cc: sfrench@samba.org, akpm@osdl.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CIFS: Use SEEK_END instead of hardcoded value

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

--

diff -r 7d3e8ba1ace3 -r e2fae9fe7a30 fs/cifs/cifsfs.c
--- a/fs/cifs/cifsfs.c	Sat Sep 16 21:00:45 2006 -0400
+++ b/fs/cifs/cifsfs.c	Sat Sep 16 21:00:45 2006 -0400
@@ -510,7 +510,7 @@ static loff_t cifs_llseek(struct file *f
 static loff_t cifs_llseek(struct file *file, loff_t offset, int origin)
 {
 	/* origin == SEEK_END => we must revalidate the cached file length */
-	if (origin == 2) {
+	if (origin == SEEK_END) {
 		int retval = cifs_revalidate(file->f_dentry);
 		if (retval < 0)
 			return (loff_t)retval;


