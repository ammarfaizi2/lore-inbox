Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTENMTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTENMTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:19:46 -0400
Received: from tomts24-srv.bellnexxia.net ([209.226.175.187]:45715 "EHLO
	tomts24-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261969AbTENMTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:19:45 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm5
Date: Wed, 14 May 2003 08:33:10 -0400
User-Agent: KMail/1.5.9
References: <20030514012947.46b011ff.akpm@digeo.com>
In-Reply-To: <20030514012947.46b011ff.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305140833.10942.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 14, 2003 04:29 am, Andrew Morton wrote:
> Various fixes.  It should even compile on uniprocessor.

OK.  It does compile.  There are a few module  problems though:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.69-mm5; fi
WARNING: /lib/modules/2.5.69-mm5/kernel/sound/isa/snd-es18xx.ko needs unknown symbol isapnp_protocol
WARNING: /lib/modules/2.5.69-mm5/kernel/arch/i386/kernel/suspend.ko needs unknown symbol enable_sep_cpu
WARNING: /lib/modules/2.5.69-mm5/kernel/arch/i386/kernel/suspend.ko needs unknown symbol default_ldt
WARNING: /lib/modules/2.5.69-mm5/kernel/arch/i386/kernel/suspend.ko needs unknown symbol init_tss
WARNING: /lib/modules/2.5.69-mm5/kernel/arch/i386/kernel/apm.ko needs unknown symbol save_processor_state
WARNING: /lib/modules/2.5.69-mm5/kernel/arch/i386/kernel/apm.ko needs unknown symbol restore_processor_state

The snd-es18xx.ko problem has existed in 69-bk for a while (I do not understand why this one happens - 
can some look at it and educate me?  Please).  The rest are new with mm5.  I have not built a recient bk to 
if they are local to mm.

Ed Tomlinson
