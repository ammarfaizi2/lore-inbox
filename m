Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTILUTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTILUTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:19:11 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:47284 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261837AbTILURg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:17:36 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.4.23-pre3] Cache size for Centrino CPU incorrect
Date: Fri, 12 Sep 2003 22:18:16 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309122218.16483.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

I just noticed this:

devilkin@precious:~$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1600MHz
stepping        : 5
cpu MHz         : 599.511
cache size      : 0 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips        : 1196.85

Somehow, the cache size doesn't seem to be correct. Spec info tells me that this cpu
has indeed a 1024kb cache.

Any patches to test?

Thankx

Jan

