Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTDHTIC (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTDHTIC (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:08:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12046 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261598AbTDHTIA (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 15:08:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Syscall numbers for BProc
Date: 8 Apr 2003 12:19:24 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6v7bs$p7l$1@cesium.transmeta.com>
References: <20030404193218.GD15620@lanl.gov> <20030405004427.GG15620@lanl.gov> <20030405064559.A2331@infradead.org> <20030405201537.GA18755@lanl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030405201537.GA18755@lanl.gov>
By author:    hendriks@lanl.gov
In newsgroup: linux.dev.kernel
> 
> The reason it is the way it is because when I'm trying to avoid
> stomping on other syscalls, having a small foot print is a good thing.
> 
> BProc will always be a fringe kind of thing.  Adding more than a
> syscall or two seems like quite a bit of polution in the main kernel
> to me.  Similarly, I don't think the main kernel should include the
> BProc patch.  It changes fairly often, isn't 100% unintrusive and
> would be used by less than .1% of people out there.
> 
> Breaking out every call into a separate syscall number would also make
> it more difficult to add new features in the future.
> 

Well, first of all, multiplexes break a lot of tools.  But worse, they
lead to really badly designed APIs partially because of lack of
review.  You have just demonstrated this phenomenon...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
