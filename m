Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVAGX6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVAGX6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVAGX6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:58:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62914 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261733AbVAGXyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:54:50 -0500
Subject: Re: uselib()  & 2.6.X?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, torvalds@osdl.org
Cc: Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050107170712.GK29176@logos.cnet>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
	 <20050107170712.GK29176@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105136446.7628.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 22:49:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't use that for mainline - do_brk_locked doesn;t follow kernel
convention and in addition you've made every case you miss (eg outside
code) fail insecure. The original patch you did that I used that adds
__do_brk() not only follows kernel convention but means anyone with
external code will end up with it fixed or with a deadlock that is easy
to track if unlucky.

Silent security failure is *bad*

Alan
 
