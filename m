Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWH1Srq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWH1Srq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWH1Srq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:47:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35777 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751329AbWH1Srp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:47:45 -0400
Subject: Re: Strange transmit corruption in jsm driver on geode sc1200
	system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060828181141.GK13641@csclub.uwaterloo.ca>
References: <20060825203047.GH13641@csclub.uwaterloo.ca>
	 <1156540817.3007.270.camel@localhost.localdomain>
	 <20060825210305.GL13639@csclub.uwaterloo.ca>
	 <20060825212441.GC2246@martell.zuzino.mipt.ru>
	 <20060825215724.GI13641@csclub.uwaterloo.ca>
	 <20060828181141.GK13641@csclub.uwaterloo.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Aug 2006 20:09:38 +0100
Message-Id: <1156792178.6271.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-28 am 14:11 -0400, ysgrifennodd Lennart Sorensen:
> Related to the SC1200, I notied cyrix.c doesn't actually know about the
> SC1200 that we are using.  This one returs dir0_msn = 11, while cyrix.c
> only knows about 0 through 5.  If I add 11 to the block handling geode

That is worth fixing.

> Does anyone know what should be called on this CPU type, and how to fix
> cyrix.c to handle it correcly rather than ignoring it?

The databook is available from www.amd.com I believe. You'd need to look
at that and see what needs setting. It is quite similar so it probably
will benefit a little - but that also depends what the BIOS does for you
and with ACPI that should be handled by the ACPI.

Alan
