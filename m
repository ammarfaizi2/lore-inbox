Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbTFQLAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 07:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264651AbTFQLAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 07:00:20 -0400
Received: from smtp0.libero.it ([193.70.192.33]:62853 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S264650AbTFQLAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 07:00:11 -0400
Subject: [PATCH] 2.5.72 smb_proc_setattr_unix warnings
From: Flameeyes <daps_mls@libero.it>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-v3a1tPN1IyYf1E9RBxIr"
Message-Id: <1055848556.997.11.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jun 2003 13:15:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v3a1tPN1IyYf1E9RBxIr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes these warnings:

  CC      fs/smbfs/proc.o
fs/smbfs/proc.c: In function `smb_proc_setattr_unix':
fs/smbfs/proc.c:3044: warning: integer constant is too large for "long"
type
fs/smbfs/proc.c:3045: warning: integer constant is too large for "long"
type
fs/smbfs/proc.c:3046: warning: integer constant is too large for "long"
type
fs/smbfs/proc.c:3047: warning: integer constant is too large for "long"
type
fs/smbfs/proc.c:3048: warning: integer constant is too large for "long"
type

it simply adds the ULL attr at the end of the constants in
include/linux/smbno.h

-- 
Flameeyes <dgp85@users.sf.net>

--=-v3a1tPN1IyYf1E9RBxIr
Content-Disposition: attachment; filename=patch-smb.diff
Content-Type: text/plain; name=patch-smb.diff; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

350,351c350,351
< #define SMB_TIME_NO_CHANGE		0xFFFFFFFFFFFFFFFF
< #define SMB_SIZE_NO_CHANGE		0xFFFFFFFFFFFFFFFF
---
> #define SMB_TIME_NO_CHANGE		0xFFFFFFFFFFFFFFFFULL
> #define SMB_SIZE_NO_CHANGE		0xFFFFFFFFFFFFFFFFULL

--=-v3a1tPN1IyYf1E9RBxIr--


