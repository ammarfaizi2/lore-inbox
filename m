Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUJTQVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUJTQVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUJTQQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:16:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:48261 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268486AbUJTQPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:15:17 -0400
Date: Wed, 20 Oct 2004 09:15:54 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, LARTC@mailman.ds9a.nl
Subject: Re: [ANNOUNCE] iproute2 2.6.9-041019
Message-Id: <20041020091554.57e60936@zqx3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.61.0410200805110.8475@boston.corp.fedex.com>
References: <41758014.4080502@osdl.org>
	<Pine.LNX.4.61.0410200805110.8475@boston.corp.fedex.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try this, ss was dragging in byteorder.h and it didn't need to.

diff -Nru a/misc/ss.c b/misc/ss.c
--- a/misc/ss.c	2004-10-20 09:13:56 -07:00
+++ b/misc/ss.c	2004-10-20 09:13:56 -07:00
@@ -33,7 +33,6 @@
 #include "libnetlink.h"
 #include "SNAPSHOT.h"
 
-#include <asm/byteorder.h>
 #include <linux/tcp.h>
 #include <linux/tcp_diag.h>
 
