Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbUKIL3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbUKIL3Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUKIL0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:26:50 -0500
Received: from canuck.infradead.org ([205.233.218.70]:56590 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261506AbUKILMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:12:52 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
From: Arjan van de Ven <arjan@infradead.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: greg@kroah.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
In-Reply-To: <zxUdaK3b.1099995467.6672570.khali@gcu.info>
References: <zxUdaK3b.1099995467.6672570.khali@gcu.info>
Content-Type: text/plain
Message-Id: <1099998753.3989.10.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 09 Nov 2004 12:12:33 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 11:17 +0100, Jean Delvare wrote:

> These functions are part of the SMBus specs. The fact that no client uses
> them for now doesn't mean that they will never be used. 

yet at the same time they bloat the kernel for everyone NOW.
If a driver magically appears that wants to use them, it's trivial to
put these in, but I see absolutely no excuse for having them in all
kernel binaries without users. This is how the kernel grows and grows
for no good reason. There's dozens of such functions all over the
kernel, and they take up unswappable memory all over. 

