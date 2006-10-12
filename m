Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWJLSkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWJLSkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWJLSkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:40:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62640 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751018AbWJLSkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:40:36 -0400
Subject: Re: [PATCH] SPI: improve sysfs compiler complaint handling
From: Arjan van de Ven <arjan@infradead.org>
To: David Brownell <david-b@pacbell.net>
Cc: Jeff Garzik <jeff@garzik.org>, dbrownell@users.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200610121108.59727.david-b@pacbell.net>
References: <20061012014920.GA13000@havoc.gtf.org>
	 <200610121108.59727.david-b@pacbell.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 12 Oct 2006 20:39:34 +0200
Message-Id: <1160678375.3000.454.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does anyone know why the GCC folk have decided to go against decades
> of common practice here???

because it's new semantics. I was involved in this GCC feature (not in
the coding just in the asking for it) and this behavior was specifically
requested: It is called __must_check, you MUST CHECK it. It's not the
normal "unused warning", by putting the attribute on the function you
tell gcc that the result MUST be checked. Just a cast to void isn't
checking it.... so it rightfully warns.



