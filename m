Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUC3GGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUC3GGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:06:10 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:38335 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261660AbUC3GGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:06:04 -0500
Date: Mon, 29 Mar 2004 21:09:17 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-Id: <20040329210917.26feb28d.pj@sgi.com>
In-Reply-To: <20040330025535.GD791@holomorphy.com>
References: <20040329041249.65d365a1.pj@sgi.com>
	<1080601576.6742.43.camel@arrakis>
	<20040329235233.GV791@holomorphy.com>
	<20040329154330.445e10e2.pj@sgi.com>
	<20040330020637.GA791@holomorphy.com>
	<20040329174637.3aa16260.pj@sgi.com>
	<20040330025535.GD791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Whether callers experience ill effects is irrelevant.

Not irrelevant to the callers ;)

And Andrew might reasonably choose to prioritize fixes,
depending in part on the impact of what they fix.

Ah - there is one more use of *_complement, in i386/mach-es7000.
But it masks the result in the next line with cpu_online_map, so
also avoids propogating the damage.


> IIRC the needed changes to cpus_shift_left() are also missing from
> your other patches in the bitmap code.

Hmmm ... could you elaborate on this?  I don't see this bug.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
