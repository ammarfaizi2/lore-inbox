Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbUCIPhh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUCIPhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:37:37 -0500
Received: from mail.humboldt.co.uk ([81.2.65.18]:47084 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S262012AbUCIPhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:37:35 -0500
Subject: Problems with 2.6.4-rc2 NFS server and diskless clients
From: Adrian Cox <adrian@humboldt.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1078846645.1441.14.camel@newt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 15:37:26 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.4-rc2  on the NFS server together with Debian unstable
(nfs-kernel-server version 1:1.0.6-1), diskless clients can no longer
mount their root filesystems. The same configuration works with a 2.4
kernel on the server.

The client reports "nfs_get_root: getattr error = 116". No error
messages appear in the server logs. And the old recipe of exporting with
"no_subtree_check" makes no difference.

Anybody have any suggestions?

The NFS part of .config on the server is:
#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set

- Adrian Cox

 

