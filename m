Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUDISzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUDISzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:55:45 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:28812 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261606AbUDISzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:55:44 -0400
Date: Fri, 9 Apr 2004 11:54:27 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, colpatch@us.ibm.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
Message-Id: <20040409115427.334e1ae7.pj@sgi.com>
In-Reply-To: <20040407042754.6b487ace.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
	<20040401131240.00f7d74d.pj@sgi.com>
	<20040406043732.6fb2df9f.pj@sgi.com>
	<200404070855.03742.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040406235000.6c06af9a.pj@sgi.com>
	<20040407042754.6b487ace.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've reduced this to a pair of bitmap.h operators:
> 
> > #define find_next_bit_in_bitmap(src, nbits, n)			\
> > 	({ int i = (n); while(i < (nbits) && !test_bit(i, (src))) i++; i; })
> > 
> > #define find_first_bit_in_bitmap(src, nbits)			\
> > 	find_next_bit_in_bitmap((src), (nbits), 0)
> 
> ...
> 
> My next mask patchset will have these.

Wrong.  My next patch set, released 8 April, did not have these.

A subsequent discussion with Nick Piggin convinced me that the
better path was to take find_next_bit() out of line, which I did
for ia64 (other arch's might also want to do this).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
