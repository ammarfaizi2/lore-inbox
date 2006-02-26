Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWBZPLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWBZPLc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 10:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWBZPLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 10:11:32 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:14912 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751113AbWBZPLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 10:11:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=COJhlPJOD+OtdtdDQ8XWOD+39exY4AIVr0yxwHC2Zd0h6fhj6GF6/K3UwUqdaa8CitP6f0O0Igkk/TR+K8NCu+wvpZkOsGAWml5nOCm7t/Sn0cLJO5TiowaxYCSukIW6qFSh8SsX80FCYrsrouECyN9GHTzKV6CgywSxmG+PImg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix implicit declaration of GET_APIC_ID in arch/i386/kernel/apic.c
Date: Sun, 26 Feb 2006 16:11:47 +0100
User-Agent: KMail/1.9.1
Cc: mingo@redhat.com, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602261611.47254.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix implicit declaration of GET_APIC_ID in arch/i386/kernel/apic.c

  arch/i386/kernel/apic.c:840: warning: implicit declaration of function `GET_APIC_ID'


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/i386/kernel/apic.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.16-rc4-mm2-orig/arch/i386/kernel/apic.c	2006-02-18 02:08:40.000000000 +0100
+++ linux-2.6.16-rc4-mm2/arch/i386/kernel/apic.c	2006-02-26 15:42:48.000000000 +0100
@@ -38,6 +38,7 @@
 #include <asm/i8253.h>
 
 #include <mach_apic.h>
+#include <mach_apicdef.h>
 #include <mach_ipi.h>
 
 #include "io_ports.h"


