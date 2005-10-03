Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVJCO7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVJCO7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVJCO7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:59:42 -0400
Received: from dvhart.com ([64.146.134.43]:56978 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750987AbVJCO7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:59:41 -0400
Date: Mon, 03 Oct 2005 07:59:43 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: David Lang <dlang@digitalinsight.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Magnus Damm <magnus@valinux.co.jp>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
Message-ID: <79580000.1128351582@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.62.0510030628150.11541@qynat.qvtvafvgr.pbz>
References: <20050930073232.10631.63786.sendpatchset@cherry.local><1128093825.6145.26.camel@localhost><aec7e5c30510021908la86daf9je0584fb0107f833a@mail.gmail.com><Pine.LNX.4.62.0510030031170.11095@qynat.qvtvafvgr.pbz><aec7e5c30510030302u8186cfer642c7b9337613de@mail.gmail.com> <Pine.LNX.4.62.0510030628150.11541@qynat.qvtvafvgr.pbz>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if nothing else preferential use of 'local' (non PAE) memory over 
> 'remote' (PAE) memory for programs, while still useing it all as needed.

Why would you want to do that? ;-)

> this may be done already, but this type of difference between the access 
> speed of different chunks of ram seems to be exactly the type of thing 
> that the NUMA code solves the general case for.

It is! 

> I'm thinking that it 
> may end up simplifying things if the same general-purpose logic will 
> work for the specific case of PAE instead of it being hard coded as 
> a special case.

But that's not the same at all! ;-) PAE memory is the same speed as
the other stuff. You just have a 3rd level of pagetables for everything.
One could (correctly) argue it made *all* memory slower, but it does so
in a uniform fashion.

M.

