Return-Path: <linux-kernel-owner+w=401wt.eu-S1751081AbXAFCHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXAFCHV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbXAFCHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:07:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55655 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbXAFCHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:07:20 -0500
Subject: Re: [patch] paravirt: isolate module ops
From: Arjan van de Ven <arjan@infradead.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <459EF537.6090301@vmware.com>
References: <20070106000715.GA6688@elte.hu>  <459EF537.6090301@vmware.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 05 Jan 2007 18:07:09 -0800
Message-Id: <1168049229.3101.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I would suggest a slightly different carving.  For one, no TLB flushes.  
> If you can't modify PTEs, why do you need to have TLB flushes?  And I 
> would allow CR0 read / write for code which saves and restores FPU state 

no that is abstracted away by kernel_fpu_begin/end. Modules have no
business doing that themselves

> - possibly even debug register access, although any code which touches 
> DRs could be doing something sneaky.  I'm on the fence about that one.

lets not allow it at all


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

