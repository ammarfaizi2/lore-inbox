Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTGATiT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTGATiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:38:19 -0400
Received: from u156n67.hfx.eastlink.ca ([24.222.156.67]:1934 "EHLO
	llama.nslug.ns.ca") by vger.kernel.org with ESMTP id S262431AbTGATiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:38:18 -0400
Date: Tue, 1 Jul 2003 16:52:41 -0300
To: linux-kernel@vger.kernel.org
Subject: 2.5.73 doesn't build without CONFIG_VT_CONSOLE
Message-ID: <20030701195241.GA2545@llama.nslug.ns.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Cordes <peter@llama.nslug.ns.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 In 2.5.73, vty_init() in drivers/char/vt.c uses console_driver, but that
variable is declared only inside an ifdef CONFIG_VT_CONSOLE.  The kernel
doesn't build without that config option.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@llama.nslug.n , s.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
