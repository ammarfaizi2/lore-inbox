Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTGXLgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 07:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTGXLgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 07:36:49 -0400
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:5638 "EHLO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with ESMTP
	id S263103AbTGXLgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 07:36:38 -0400
Date: Thu, 24 Jul 2003 13:42:26 +0000 (UTC)
From: "Wojciech \"Sas\" Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1-ac3 and PPC
Message-ID: <Pine.LNX.4.44L.0307241335520.24052-200000@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1667897478-1692890599-1059054146=:24052"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1667897478-1692890599-1059054146=:24052
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,=20
I try to build 2.6.0-test1-ac3 on PPC

in .config I have:

CONFIG_SMP=3Dy
CONFIG_IRQ_ALL_CPUS=3Dy
CONFIG_NR_CPUS=3D32
# CONFIG_ALTIVEC is not set
CONFIG_TAU=3Dy
# CONFIG_TAU_INT is not set
# CONFIG_TAU_AVERAGE is not set
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_PROC_INTF=3Dy
CONFIG_CPU_FREQ_24_API=3Dy
CONFIG_CPU_FREQ_PMAC=3Dy

and I got error:
  CC      arch/ppc/platforms/pmac_cpufreq.o
arch/ppc/platforms/pmac_cpufreq.c: In function `do_set_cpu_speed':
arch/ppc/platforms/pmac_cpufreq.c:180: error: `CPUFREQ_ALL_CPUS' undeclared=
 (first use in this function)
arch/ppc/platforms/pmac_cpufreq.c:180: error: (Each undeclared identifier i=
s reported only once
arch/ppc/platforms/pmac_cpufreq.c:180: error: for each function it appears =
in.)
make[1]: *** [arch/ppc/platforms/pmac_cpufreq.o] B=B3=B1d 1
make: *** [arch/ppc/platforms] B=B3=B1d 2

I solve this with included patch.

Please check and applay.

Thanx.
=09=09=09=09=09Sas.
P.S.
In file include/asm-ppc/smp.h is missing line:
#include <inclide/threads.h>
--=20
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                              =
 }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciw=
a}

---1667897478-1692890599-1059054146=:24052
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pmac_cpufreq.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44L.0307241342260.24052@alpha.zarz.agh.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="pmac_cpufreq.patch"

LS0tIGxpbnV4LTIuNi4wLXRlc3QxL2FyY2gvcHBjL3BsYXRmb3Jtcy9wbWFj
X2NwdWZyZXEuYy5vcmcJVGh1IEp1bCAyNCAxMTozOToxMyAyMDAzDQorKysg
bGludXgtMi42LjAtdGVzdDEvYXJjaC9wcGMvcGxhdGZvcm1zL3BtYWNfY3B1
ZnJlcS5jCVRodSBKdWwgMjQgMTE6Mzk6NTQgMjAwMw0KQEAgLTM2LDYgKzM2
LDcgQEANCiAjZGVmaW5lIFBNQUNfQ1BVX0xPV19TUEVFRAkxDQogI2RlZmlu
ZSBQTUFDX0NQVV9ISUdIX1NQRUVECTANCiANCisjZGVmaW5lIENQVUZSRVFf
QUxMX0NQVVMJKChOUl9DUFVTKSkNCiBzdGF0aWMgaW5saW5lIHZvaWQNCiB3
YWtldXBfZGVjcmVtZW50ZXIodm9pZCkNCiB7DQo=
---1667897478-1692890599-1059054146=:24052--
