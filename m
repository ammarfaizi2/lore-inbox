Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTJEUHi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 16:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTJEUHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 16:07:38 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:25748 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263871AbTJEUHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 16:07:36 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031005191344.GA963@elf.ucw.cz>
References: <1065266733.16088.91.camel@imladris.demon.co.uk>
	 <20031005161155.GA753@elf.ucw.cz>
	 <20031005171916.B21478@flint.arm.linux.org.uk>
	 <20031005191344.GA963@elf.ucw.cz>
Message-Id: <1065384453.3157.149.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Sun, 05 Oct 2003 21:07:33 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: Re: JFFS2 swsusp / signal cleanup.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-10-05 at 21:13 +0200, Pavel Machek wrote:
> Should I do recalc_sigpending() instead of flush_signals(current)?

Yes. You can do that unconditionally, too -- no need to do it depending
on an argument from the caller.

-- 
dwmw2


