Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUGSJ6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUGSJ6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 05:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUGSJ6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 05:58:20 -0400
Received: from math.ut.ee ([193.40.5.125]:62963 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264913AbUGSJ6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 05:58:19 -0400
Date: Mon, 19 Jul 2004 12:58:17 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: TEA crypto in 2.4: undefined MODULE_ALIAS
Message-ID: <Pine.GSO.4.44.0407191253370.14892-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to compile 2.4.27-BK on PPC and activated TEA crypto option
as a module. I get this compile error:

gcc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/home/mroos/compile/linux-2.4/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DMODULE -DMODVERSIONS -include /home/mroos/compile/linux-2.4/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=tea  -c -o tea.o tea.c
tea.c:242: error: parse error before string constant
tea.c:242: warning: type defaults to `int' in declaration of `MODULE_ALIAS'
tea.c:242: warning: function declaration isn't a prototype
tea.c:242: warning: data definition has no type or storage class

It seems that MODULE_ALIAS is undefined in 2.4. Shoulw we remove this
line from tea.c or add MODULE_ALIAS definition to 2.4?

-- 
Meelis Roos (mroos@linux.ee)

