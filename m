Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbUDGOq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUDGOq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:46:59 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:33158 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263696AbUDGOqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:46:30 -0400
Date: Wed, 7 Apr 2004 07:44:41 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, colpatch@us.ibm.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
Message-Id: <20040407074441.5070b58d.pj@sgi.com>
In-Reply-To: <40740C90.3060005@yahoo.com.au>
References: <20040401122802.23521599.pj@sgi.com>
	<20040401131240.00f7d74d.pj@sgi.com>
	<20040406043732.6fb2df9f.pj@sgi.com>
	<200404070855.03742.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040406235000.6c06af9a.pj@sgi.com>
	<20040407004437.3a078f28.pj@sgi.com>
	<40740C90.3060005@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> No, the schedule() fastpath doesn't use find_next_bit. 

Ok - makes sense - thanks.

Uninlining it is perhaps the easiest way out.

That or replacing it with the trivial version that is several times
smaller (loops one bit at a time, checking 'test_bit()').

Right now, I don't see any excuse for that fat version of find_next_bit()
to exist.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
