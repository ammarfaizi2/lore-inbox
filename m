Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTIZGEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 02:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbTIZGEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 02:04:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38279 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261947AbTIZGEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 02:04:42 -0400
Date: Thu, 25 Sep 2003 22:51:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: Urban.Widmark@enlight.net
Cc: linux-kernel@vger.kernel.org
Subject: buggy changes to fs/smbfs/inode.c
Message-Id: <20030925225116.433e1c53.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Your changes to fs/smbfs/inode.c do not build on platforms
that do not define CONFIG_UID16.  You cannot use low2highuid()
unless CONFIG_UID16 is known to be defined.
