Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTJQJ5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTJQJ5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:57:52 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:44496 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263378AbTJQJ5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:57:51 -0400
Subject: Re: Access MTD device from kernel module?
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Shih <alan@storlinksemi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ODEIIOAOPGGCDIKEOPILKEEKDOAA.alan@storlinksemi.com>
References: <ODEIIOAOPGGCDIKEOPILKEEKDOAA.alan@storlinksemi.com>
Content-Type: text/plain
Message-Id: <1066384669.6744.1194.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Fri, 17 Oct 2003 10:57:49 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 13:43 -0700, Alan Shih wrote:
> I got stuck with a problem regarding a hardware driver (i.e. NIC driver)
> trying to read a MTD partition.
> 
> I know I can export MTD's functions as kernel symbols but not sure if that's
> the best way to do this.

struct mtd_info *mtd = get_mtd_device(NULL, mtd_nr);

mtd->read(...);

put_mtd_device(mtd);


-- 
dwmw2

