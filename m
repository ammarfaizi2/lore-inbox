Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWGDVo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWGDVo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWGDVo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:44:28 -0400
Received: from mx1.suse.de ([195.135.220.2]:49077 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751228AbWGDVo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:44:28 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 2/2] i386 TIF flags for debug regs and io bitmap in ctxsw
Date: Tue, 4 Jul 2006 23:47:00 +0200
User-Agent: KMail/1.9.1
Cc: Stephane Eranian <eranian@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200607041719_MC3-1-C420-EC5A@compuserve.com>
In-Reply-To: <200607041719_MC3-1-C420-EC5A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607042347.00598.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 July 2006 23:19, Chuck Ebbert wrote:
> In-Reply-To: <20060704072939.GC5902@frankl.hpl.hp.com>
>
> On Tue, 4 Jul 2006 00:29:39 -0700, Stephane Eranian wrote:
> > Following my discussion with Andi. Here is a patch that introduces
> > two new TIF flags to simplify the context switch code in __switch_to().
> > The idea is to minimize the number of cache lines accessed in the common
> > case, i.e., when neither the debug registers nor the I/O bitmap are used.
>
> I get a 5-10% speedup in task switch times with this patch.

That sounds too much. How did you measure it?

Note that lmbench tends to be unstable for this.

-Andi
