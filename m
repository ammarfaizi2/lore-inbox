Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbTISJbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 05:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTISJbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 05:31:50 -0400
Received: from sophia.inria.fr ([138.96.64.20]:9671 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S261448AbTISJbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 05:31:47 -0400
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Reply-To: Nicolas.Turro@sophia.inria.fr
Organization: INRIA Sophia
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbols in /tmp/lib/modules/2.4.22/kernel/....
Date: Fri, 19 Sep 2003 11:31:46 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309191131.46084.Nicolas.Turro@sophia.inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, during kernel compilation, i get loads of 
unresolv sympols during this step :
 
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b /tmp -r 2.4.22; 
fi

kmalloc, kfree and tons of other essencial stuff seem to be missing.


> grep kfree System.map
c01288b4 T kfree
c019cb90 t ino_lnkfree
c026b448 T sock_kfree_s
c026c0d0 T kfree_skbmem
c026c124 T __kfree_skb
c0317abe R __kstrtab_kfree
c031c93e R __kstrtab_sock_kfree_s
c031d0b0 R __kstrtab___kfree_skb
c031f930 R __ksymtab_kfree
c0321ed8 R __ksymtab_sock_kfree_s
c0322290 R __ksymtab___kfree_skb

nm -V
GNU nm 2.13.90.0.2 20020802
depmod -V
depmod version 2.4.12


Any ideas ?


N. Turro
