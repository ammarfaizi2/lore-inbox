Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267836AbUHEVre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267836AbUHEVre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267581AbUHEVqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:46:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38299 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267875AbUHEVp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:45:59 -0400
Date: Thu, 5 Aug 2004 14:45:29 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: akpm@osdl.org, hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de,
       lse-tech@lists.sourceforge.net, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] new bitmap list format (for cpusets)
Message-Id: <20040805144529.3d9c1fc2.pj@sgi.com>
In-Reply-To: <250840000.1091738840@flay>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<250840000.1091738840@flay>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin asks:
> Can't we just do this up in userspace, ...

Aha - I was expecting this question.  Howdy.

We could, I suppose (do this fancy bitmap formatting in userland).

It's certainly been a pleasure to Simon Derr, Sylvain Jeaugey and
myself, over the last six months, to be able to easily manipulate
these big masks using classic Unix commands like cat and echo.

The ability to atomically update a mask is unique to this interface.
The existing bitmap_parse/bitmap_scnprintf interface only allows
for a complete rewrite, not atomically adding or removing a node.

However, I am not aware of a reason why we need the atomic update.

Simon ... could you comment on this, and perhaps better motivate
          this new bitmap list format?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
