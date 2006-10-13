Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWJML4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWJML4Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 07:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWJML4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 07:56:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54163 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751424AbWJML4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 07:56:15 -0400
Subject: Re: [PATCH] drivers/char/riscom8.c: save_flags()/cli()/sti()
	removal
From: Arjan van de Ven <arjan@infradead.org>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
In-Reply-To: <1160739628.19143.376.camel@amol.verismonetworks.com>
References: <1160739628.19143.376.camel@amol.verismonetworks.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 13 Oct 2006 13:56:12 +0200
Message-Id: <1160740572.3000.489.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 17:10 +0530, Amol Lad wrote:
> Removed save_flags()/cli()/sti() and used (light weight) spin locks

Hi,

I applaud removing such legacy-should-be-dead-by-now functions; however,
I'm not entirely sure your conversion is correct. While you convert all
places that do cli/sti with locks.... you do not seem to be adding the
locks to the places that the cli/sti pairs protected against (the IRQ
handlers).... so it looks like your conversion is incomplete ;(

Greetings,
    Arjan van de Ven

