Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263716AbUDGPWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 11:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUDGPWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 11:22:45 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:29637 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263721AbUDGPWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 11:22:19 -0400
Date: Wed, 7 Apr 2004 08:21:41 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, colpatch@us.ibm.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
Message-Id: <20040407082141.1e5bd509.pj@sgi.com>
In-Reply-To: <40741819.5060001@yahoo.com.au>
References: <20040401122802.23521599.pj@sgi.com>
	<20040401131240.00f7d74d.pj@sgi.com>
	<20040406043732.6fb2df9f.pj@sgi.com>
	<200404070855.03742.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040406235000.6c06af9a.pj@sgi.com>
	<20040407004437.3a078f28.pj@sgi.com>
	<40740C90.3060005@yahoo.com.au>
	<20040407074441.5070b58d.pj@sgi.com>
	<40741819.5060001@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The uninlined larger version would have to be smaller and
> faster than your small version inlined, wouldn't it?

Yes - a normal function call with 3 args will be smaller than
an inline for-loop with a test_bit().

Faster depends - small or dense would favor the inline,
large and sparse the larger version via a call.

You raise good points.  Thanks.

Looks like uninlining it is the sensible choice.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
