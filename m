Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVDHOPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVDHOPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVDHOPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:15:31 -0400
Received: from mail.portrix.net ([212.202.157.208]:62923 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262824AbVDHOOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:14:38 -0400
Message-ID: <425691BD.9080507@portrix.net>
Date: Fri, 08 Apr 2005 16:14:21 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm2
References: <20050408030835.4941cd98.akpm@osdl.org>
In-Reply-To: <20050408030835.4941cd98.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> - The bk-acpi patch here causes my ia64 test box to hang during boot

>  bk-ia64.patch

ia64 defconfig does not even build anymore:


  CC [M]  drivers/char/agp/hp-agp.o
In file included from /usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:18:
include2/asm/acpi-ext.h:15: error: parse error before "hp_acpi_csr_space"
include2/asm/acpi-ext.h:15: error: parse error before "u64"
include2/asm/acpi-ext.h:15: warning: type defaults to `int' in declaration of `hp_acpi_csr_space'
include2/asm/acpi-ext.h:15: warning: function declaration isn't a prototype
include2/asm/acpi-ext.h:15: warning: data definition has no type or storage class
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c: In function `hp_zx1_configure':
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:255: warning: large integer implicitly truncated to unsigned type
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c: At top level:
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:477: warning: type defaults to `int' in declaration of `acpi_status'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:477: error: parse error before "zx1_gart_probe"
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:480: warning: type defaults to `int' in declaration of `status'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:480: warning: data definition has no type or storage class
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:486: warning: type defaults to `int' in declaration of `status'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:486: error: `obj' undeclared here (not in a function)
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:486: error: initializer element is not constant
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:486: warning: data definition has no type or storage class
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:487: error: parse error before "if"
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:491: warning: type defaults to `int' in declaration of `handle'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:491: error: `obj' undeclared here (not in a function)
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:491: warning: data definition has no type or storage class
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:492: error: parse error before "do"
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:494: warning: type defaults to `int' in declaration of `status'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:494: error: redefinition of `status'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:486: error: `status' previously defined here
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:494: warning: implicit declaration of function `acpi_get_object_info'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:494: error: initializer element is not constant
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:494: warning: data definition has no type or storage class
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:495: error: parse error before "if"
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:499: warning: type defaults to `int' in declaration of `match'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:499: error: dereferencing pointer to incomplete type
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:499: error: initializer element is not constant
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:499: warning: data definition has no type or storage class
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:500: warning: type defaults to `int' in declaration of `ACPI_MEM_FREE'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:500: warning: parameter names (without types) in function declaration
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:500: warning: data definition has no type or storage class
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:501: error: parse error before "if"
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:513: warning: type defaults to `int' in declaration of `status'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:513: error: redefinition of `status'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:494: error: `status' previously defined here
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:513: warning: implicit declaration of function `acpi_get_parent'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:513: error: `parent' undeclared here (not in a function)
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:513: error: initializer element is not constant
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:513: warning: data definition has no type or storage class
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:514: warning: type defaults to `int' in declaration of `handle'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:514: error: redefinition of `handle'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:491: error: `handle' previously defined here
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:514: error: `parent' undeclared here (not in a function)
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:514: warning: data definition has no type or storage class
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:515: error: parse error before '}' token
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:520: error: parse error before string constant
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:521: warning: type defaults to `int' in declaration of `context'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:521: warning: type defaults to `int' in declaration of `sba_hpa'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:521: error: conflicting types for `sba_hpa'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:483: error: previous declaration of `sba_hpa'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:521: error: parse error before '+' token
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:523: warning: type defaults to `int' in declaration of `hp_zx1_gart_found'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:523: error: conflicting declarations of `hp_zx1_gart_found'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:49: error: `hp_zx1_gart_found' previously declared here
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:523: warning: data definition has no type or storage class
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:524: error: parse error before "return"
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c: In function `agp_hp_init':
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:533: warning: implicit declaration of function `acpi_get_devices'
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:533: error: `zx1_gart_probe' undeclared (first use in this function)
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:533: error: (Each undeclared identifier is reported only once
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:533: error: for each function it appears in.)
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c: At top level:
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:481: error: storage size of `buffer' isn't known
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:49: warning: `hp_zx1_gart_found' defined but not used
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:446: warning: `hp_zx1_setup' defined but not used
/usr/src/ctest/mm/kernel/drivers/char/agp/hp-agp.c:477: warning: `acpi_status' defined but not used
{standard input}: Assembler messages:
{standard input}:72: Error: symbol `hp_zx1_gart_found' is already defined
{standard input}:133: Error: symbol `status' is already defined
{standard input}:139: Error: symbol `status' is already defined
{standard input}:145: Error: symbol `handle' is already defined
make[4]: *** [drivers/char/agp/hp-agp.o] Error 1
make[3]: *** [drivers/char/agp] Error 2
make[2]: *** [drivers/char] Error 2
make[1]: *** [drivers] Error 2
make: *** [_all] Error 2

See http://l4x.org/k/?d=3211

Jan
