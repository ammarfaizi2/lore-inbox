Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWDCEQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWDCEQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 00:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWDCEQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 00:16:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8851 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932360AbWDCEQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 00:16:33 -0400
Date: Sun, 2 Apr 2006 23:16:32 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: fix S390 implicit declaration of (un)likely.
Message-ID: <20060403041632.GA8980@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm/atomic.h:94: warning: implicit declaration of function 'unlikely'
include/asm/atomic.h:97: warning: implicit declaration of function 'likely'

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.16.noarch/include/asm-s390/atomic.h~	2006-04-01 00:07:45.000000000 -0500
+++ linux-2.6.16.noarch/include/asm-s390/atomic.h	2006-04-01 00:08:08.000000000 -0500
@@ -1,6 +1,8 @@
 #ifndef __ARCH_S390_ATOMIC__
 #define __ARCH_S390_ATOMIC__
 
+#include <linux/compiler.h>
+
 /*
  *  include/asm-s390/atomic.h
  *
