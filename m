Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbTDRQR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbTDRQR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:17:26 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:19830 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263206AbTDRQRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:17:09 -0400
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs (2/7) - minor miscdev changes
References: <20030418181250.B363@lst.de>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 18 Apr 2003 09:29:00 -0700
In-Reply-To: <20030418181250.B363@lst.de>
Message-ID: <52znmn7os3.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 18 Apr 2003 16:29:02.0536 (UTC) FILETIME=[9F46E480:01C305C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 int misc_register(struct miscdevice * misc)
 {
-	static devfs_handle_t devfs_handle, dir;
 	struct miscdevice *c;
+	char buf[256];

    Wouldn't it be better not to have a 256-byte buffer on the stack?

 - Roland
