Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266930AbTGKV6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbTGKV6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:58:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62392
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266930AbTGKV6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:58:21 -0400
Subject: Re: SECURITY - data leakage due to incorrect strncpy implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <1057959932.20637.51.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0307112100240.843-100000@artax.karlin.mff.cuni.cz>
	 <1057959932.20637.51.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057961423.20637.68.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 23:10:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok an update:

2.4 you have a problem if your port uses the lib/string.c
implementation. x86 does not and is ok (very nifty implementation of the
zeroing too)

That appears to be: 

Not vulnerable: x86 
Buggy generic: ARM, CRIS, IA-64, PA-RISC, S/390, SH64, SPARC, SPARC64,
X86-64
Buggy asm: m68k, mips (?), sh, 
Unknown: alpha, ppc

2.5 you have problems all over the place from wrong strlcpy conversions,
but those are easy enough to clean up before 2.6.0
