Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWGBRhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWGBRhu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWGBRhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:37:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48614 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751345AbWGBRht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:37:49 -0400
Subject: Re: isa_memcpy_fromio
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen.Clark@seclark.us
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44A7FBBE.9070809@seclark.us>
References: <44A732E3.10202@seclark.us>
	 <1151834671.14346.5.camel@localhost.localdomain>
	 <20060702090713.bd3a2e68.rdunlap@xenotime.net>
	 <44A7FBBE.9070809@seclark.us>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 19:37:44 +0200
Message-Id: <1151861865.3111.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Would someone recommend how this should be changed?
> 

Hi,

the kernel already has a full DMI decoder, this module appears to just
try to duplicate it (at least judging on the snippet you pasted). It'd
be a lot better if the module would just use the existing DMI layer...
If it did that then it doesn't need isa_memcpy_fromio() *at all*...

see the drivers/firmware/dmi_scan.c file for the linux DMI layer code.

Greetings,
   Arjan van de Ven

