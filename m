Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263806AbRFMOWK>; Wed, 13 Jun 2001 10:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263886AbRFMOWA>; Wed, 13 Jun 2001 10:22:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10918 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263806AbRFMOVu>;
	Wed, 13 Jun 2001 10:21:50 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.30453.762432.702411@pizda.ninka.net>
Date: Wed, 13 Jun 2001 07:21:41 -0700 (PDT)
To: Keith Owens <kaos@ocs.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: <10322.992441398@ocs4.ocs-net>
In-Reply-To: <15143.29246.712747.936864@pizda.ninka.net>
	<10322.992441398@ocs4.ocs-net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens writes:
 > #define my_symbol       my_symbol_versioned
 > extern void my_symbol(void);
 > 
 > void foo(void) { __asm__("call %0" : : "i" (my_symbol)); }
 > 
 > # gcc -o x x.c
 > /tmp/cclWXduj.s: Assembler messages:
 > /tmp/cclWXduj.s:12: Error: suffix or operands invalid for `call'

I can't believe there is no reliable way to get rid of that
pesky "$" gcc is adding to the symbol.  Oh well...

Later,
David S. Miller
davem@redhat.com
