Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263674AbRFMOKk>; Wed, 13 Jun 2001 10:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263752AbRFMOKa>; Wed, 13 Jun 2001 10:10:30 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:60915 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S263674AbRFMOKY>;
	Wed, 13 Jun 2001 10:10:24 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: Your message of "Wed, 13 Jun 2001 07:01:34 MST."
             <15143.29246.712747.936864@pizda.ninka.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 00:09:58 +1000
Message-ID: <10322.992441398@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001 07:01:34 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>Why doesn't this work on x86?
>
>#define my_symbol	my_symbol_versioned
>extern void my_symbol(void);
>
>__asm__("call %0" : : "i" (my_symbol));

#define my_symbol       my_symbol_versioned
extern void my_symbol(void);

void foo(void) { __asm__("call %0" : : "i" (my_symbol)); }

# gcc -o x x.c
/tmp/cclWXduj.s: Assembler messages:
/tmp/cclWXduj.s:12: Error: suffix or operands invalid for `call'

