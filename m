Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVBOWNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVBOWNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVBOWNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:13:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:65233 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261914AbVBOWNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:13:05 -0500
Date: Tue, 15 Feb 2005 14:10:22 -0800
From: Paul Jackson <pj@sgi.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: holt@sgi.com, haveblue@us.ibm.com, raybry@sgi.com, taka@valinux.co.jp,
       hugh@veritas.com, akpm@osdl.org, marcello@cyclades.com,
       raybry@austin.rr.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
 sys_page_migrate
Message-Id: <20050215141022.3b99df87.pj@sgi.com>
In-Reply-To: <16914.28795.316835.291470@wombat.chubb.wattle.id.au>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
	<1108242262.6154.39.camel@localhost>
	<20050214135221.GA20511@lnx-holt.americas.sgi.com>
	<1108407043.6154.49.camel@localhost>
	<20050214220148.GA11832@lnx-holt.americas.sgi.com>
	<20050215074906.01439d4e.pj@sgi.com>
	<20050215162135.GA22646@lnx-holt.americas.sgi.com>
	<20050215083529.2f80c294.pj@sgi.com>
	<20050215185943.GA24401@lnx-holt.americas.sgi.com>
	<16914.28795.316835.291470@wombat.chubb.wattle.id.au>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr Peter Chubb writes:
> Can page migration be done lazily, instead of all at once?

That might be a useful option.  Not my area to comment on.

We would also require, at least as an option, to be able to force the
migration on demand.  Some of our big honkin iron parallel jobs run with
a high degree of parallelism, and nearly saturate each node being used. 
For jobs like that, it can be better to get everything in place, before
resuming execution.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
