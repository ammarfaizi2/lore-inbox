Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWGBJrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWGBJrm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 05:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWGBJrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 05:47:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59298 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964779AbWGBJrm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 05:47:42 -0400
Subject: Re: isa_memcpy_fromio
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen.Clark@seclark.us
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44A732E3.10202@seclark.us>
References: <44A732E3.10202@seclark.us>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Jul 2006 11:04:31 +0100
Message-Id: <1151834671.14346.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-07-01 am 22:43 -0400, ysgrifennodd Stephen Clark:
> Hello,
> 
> what has isa_memcpy_fromio() changed to in kernel 2.6.17 from 2.6.16

It was always meant as a transition interface (although it survived
incredibly long). All code that uses the ioremap is unaffected: ie

	foo = ioremap(isa_addr, len);
	memcpy_fromio(foo + bar, buf, len2)


