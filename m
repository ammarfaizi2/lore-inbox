Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbRFADJF>; Thu, 31 May 2001 23:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263335AbRFADIz>; Thu, 31 May 2001 23:08:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40629 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263333AbRFADIj>;
	Thu, 31 May 2001 23:08:39 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15127.1842.442105.847057@pizda.ninka.net>
Date: Thu, 31 May 2001 20:08:34 -0700 (PDT)
To: Felix von Leitner <leitner@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: include/asm-sparc/ptrace.h is broken
In-Reply-To: <20010531231516.A28350@fefe.de>
In-Reply-To: <20010531231516.A28350@fefe.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Felix von Leitner writes:
 > on line 76, it includes <asm/asm_offsets.h>, which does not exist.
 > 
 > This is critical because this include file does not work when used from
 > a libc.  ptrace.h is from 1997 on my 2.4.5 kernel, so this is not
 > something that broke recently.
 > 
 > My suggestion is to remove the offending line altogether or at least
 > protect it with #ifdef __KERNEL__.

Just like other headers in the kernel (such as linux/autoconfig.h)
they do not exist until the kernel is configured and built.

include asm-sparc{,64}/asm_offsets.h is built at kernel build time.

Later,
David S. Miller
davem@redhat.com
