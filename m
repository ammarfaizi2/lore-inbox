Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbVKWXdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVKWXdW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVKWXdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:33:22 -0500
Received: from fmr22.intel.com ([143.183.121.14]:41678 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751317AbVKWXdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:33:20 -0500
Message-Id: <200511232333.jANNX9g23967@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <con@kolivas.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Kernel BUG at mm/rmap.c:491
Date: Wed, 23 Nov 2005 15:33:09 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXwhQTupApK1pNZQiKuiYrFOHIVswAABsYA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <cone.1132788250.534735.25446.501@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Wednesday, November 23, 2005 3:24 PM
> Chen, Kenneth W writes:
> 
> > Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
> > 
> > Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
> > 
> > Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
> 
>                        ^^^^^^^^^^
> 
> Please try to reproduce it without proprietary binary modules linked in.


???, I'm not using any modules at all.

[albat]$ /sbin/lsmod
Module                  Size  Used by
[albat]$ 


Also, isn't it 'P' indicate proprietary module, not 'G'?
line 159: kernel/panic.c:

        snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
                tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',

- Ken

