Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVALKtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVALKtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 05:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVALKtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 05:49:23 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:20142 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261324AbVALKtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 05:49:20 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Date: Wed, 12 Jan 2005 10:49:10 +0000
User-Agent: KMail/1.7.2
Cc: Mariusz Mazur <mmazur@kernel.pl>
References: <200501081613.27460.mmazur@kernel.pl>
In-Reply-To: <200501081613.27460.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121049.10219.andrew@walrond.org>
X-Spam-Score: 4.3 (++++)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 January 2005 15:13, Mariusz Mazur wrote:

Upgrading from 2.6.9.1 to 2.6.10.0 causes a mysql build failure on x86:

gcc -DDEFAULT_CHARSET_HOME=\"/pkg/mysql.1\" -DDATADIR=\"/pkg/mysql.1/state\" 
-DSHAREDIR=\"/pkg/mysql.1/share/mysql\" -DDONT_USE_RAID -DMYSQL_CLIENT -fPIC 
-I. -I. -I.. -I../include -O3 -DDBUG_OFF -march=i686 -O2 -MT password.lo -MD 
-MP -MF .deps/password.Tpo -c password.c  -fPIC -DPIC -o .libs/password.o
In file included from ../include/my_global.h:291,
                 from password.c:62:
/usr/include/asm/atomic.h: In function `atomic_add_return':
/usr/include/asm/atomic.h:189: error: `boot_cpu_data' undeclared (first use in 
this function)

It builds fine on x86_64 though. I don't know where the fault lies here; 
mysql, libc-headers or linux-2.6.10, so this is just a FYI.

Andrew Walrond
