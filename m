Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271155AbTHHCjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 22:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271156AbTHHCjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 22:39:07 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:21644 "HELO
	develer.com") by vger.kernel.org with SMTP id S271155AbTHHCjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 22:39:05 -0400
Message-ID: <3F330D46.8020508@develer.com>
Date: Fri, 08 Aug 2003 04:39:02 +0200
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: gcc@gcc.gnu.org
CC: linux-kernel@vger.kernel.org
Subject: Big kernel size increase with gcc 3.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

these figures speak for themselves:

   text    data     bss     dec     hex filename
 833352   47200   78884  959436   ea3cc linux-2.6.x/vmlinux_gcc331
 877420   53212   78884 1009516   f676c linux-2.6.x/vmlinux_gcc34


 - target is linux-2.6.0-test2-uc0 for m68knommu (full config
   available on request);

 - same optimization flags: -m5307 -O2 -fno-strict-aliasing
      -fno-common -fno-builtin -fomit-frame-pointer

 - same ColdFire GCC patches were used (I strongly doubt it
   could be a back-end issue);

 - gcc-3.3.1-20030720 VS gcc-3.4-20030806.

I can provide more datails if needed. Could be an inlining issue
of course.

Out of curiosity, it seems that the old 2.95.3 could finally be
sent to rest now:

   text    data     bss     dec     hex filename
  833352   47200   78884  959436   ea3cc linux-2.6.x/vmlinux_gcc331
  857208   72800   60836  990844   f1e7c linux-2.6.x/vmlinux_gcc295

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html



