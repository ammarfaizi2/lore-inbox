Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268469AbTANBJ6>; Mon, 13 Jan 2003 20:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268470AbTANBJ6>; Mon, 13 Jan 2003 20:09:58 -0500
Received: from fmr05.intel.com ([134.134.136.6]:49884 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S268469AbTANBJ5>; Mon, 13 Jan 2003 20:09:57 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2602CB5E31@pdsmsx32.pd.intel.com>
From: "Fu, Michael" <michael.fu@intel.com>
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: [ANNOUNCE] kexec-tools-1.8
Date: Tue, 14 Jan 2003 09:16:30 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-12-02 at 04:41:34, Eric wrote:
>kexec-tools-1.8 is now available at :
>http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.8.tar.gz

I can't use the kexec program in the package to load a bzImage file. The
following simple patch make it work.


diff -ru kexec-tools-1.8-orig/kexec/kexec.c kexec-tools-1.8/kexec/kexec.c
--- kexec-tools-1.8-orig/kexec/kexec.c	Mon Jan 13 11:21:28 2003
+++ kexec-tools-1.8/kexec/kexec.c	Mon Jan 13 11:21:50 2003
@@ -159,7 +159,7 @@
 	}
 	for(i = 0; i < file_types; i++) {
 		if (type && (strcmp(type, file_type[i].name) != 0)) {
-			break;
+			continue;
 		}
 		if (file_type[i].probe(fp_kernel) > 0) {
 			break;



Michael
Not speaking for Intel,   options are my own.
