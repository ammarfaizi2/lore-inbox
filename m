Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWHIRtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWHIRtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWHIRtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:49:03 -0400
Received: from qb-out-0506.google.com ([72.14.204.235]:36414 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751233AbWHIRtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:49:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tc0wiBqP2Q+Do4sEdO2Hq+/uSQqv1wZeMPyxaljn7b5H+BNrdq7ekeSXecWGgvL1DG1N25Od243ayIY5rMPV4Ttjy1Rf1f9MLds1D0g9OtFZnNSpECXcZdJ+ImlEwoBs5DwLtYLGS1XWgJfbLK9lVz6ZKA9irjHJqELi3bfmQGw=
Message-ID: <b572c9e10608091049q5223adddxb2fd854c31877670@mail.gmail.com>
Date: Wed, 9 Aug 2006 13:49:00 -0400
From: "Forrest Voight" <voights@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] arch/i386/kernel/cpu/transmeta.c, kernel 2.6.17.8
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corrects warning:

  CC      arch/i386/kernel/cpu/centaur.o
  CC      arch/i386/kernel/cpu/transmeta.o
arch/i386/kernel/cpu/transmeta.c: In function 'init_transmeta':
arch/i386/kernel/cpu/transmeta.c:12: warning: 'cpu_freq' may be used
uninitialized in this function
  CC      arch/i386/kernel/cpu/intel.o



--- linux-2.6.17.8/arch/i386/kernel/cpu/transmeta.c     2006-08-07
00:18:54.000000000 -0400
+++ linux/arch/i386/kernel/cpu/transmeta.c      2006-08-09
13:32:05.000000000 -0400
@@ -9,7 +9,7 @@
 {
        unsigned int cap_mask, uk, max, dummy;
        unsigned int cms_rev1, cms_rev2;
-       unsigned int cpu_rev, cpu_freq, cpu_flags, new_cpu_rev;
+       unsigned int cpu_rev, cpu_freq = 0, cpu_flags, new_cpu_rev;
        char cpu_info[65];

        get_model_name(c);      /* Same as AMD/Cyrix */
