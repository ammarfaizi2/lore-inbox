Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVLZUv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVLZUv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 15:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVLZUv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 15:51:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44168 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932147AbVLZUvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 15:51:25 -0500
Subject: Re: Is there any Buffer overflow attack mechanism that can break a
	vulnerable server without breaking the ongoing connection?
From: Arjan van de Ven <arjan@infradead.org>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4ae3c140512261247p612146f5w6ad8bf474f4ebfd5@mail.gmail.com>
References: <4ae3c140512261247p612146f5w6ad8bf474f4ebfd5@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 21:51:21 +0100
Message-Id: <1135630282.3910.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 15:47 -0500, Xin Zhao wrote:
> We are working on a mechanism that monitors the connections of a
> server and detects potential intrusions via broken connection
> (incoming request received, but no reply).  We want to thoroughly
> understand the possibility of mounting a buffer overflow attack
> against a server process without cutting off the connection.

buffer overflows do not break connections, and as such I think you are
out of luck.
Having said that.. on modern linux distros it's pretty hard to do a
buffer overflow exploit nowadays (NX[1] to make stacks non-executable,
randomisations, compiler based detection (via FORTIFY_SOURCE and/or
-fstackprotector)... add all those together and it's certainly not easy
to do this....



[1] or emulations of NX such as segment limits techniques

