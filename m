Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUAHKQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUAHKQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:16:28 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:926 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263963AbUAHKQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:16:27 -0500
Date: Thu, 8 Jan 2004 02:16:58 -0800
From: Paul Jackson <pj@sgi.com>
To: Jesper Juhl <juhl@dif.dk>
Cc: joe@perches.com, juhl-lkml@dif.dk, linux-kernel@vger.kernel.org,
       markhe@nextd.demon.co.uk, andrea@e-mind.com, manfred@colorfullife.com
Subject: Re: [PATCH] mm/slab.c remove impossible <0 check - size_t is not
 signed - patch is against 2.6.1-rc1-mm2
Message-Id: <20040108021658.0a8aaccc.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.56.0401081032590.10083@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401080204060.9700@jju_lnx.backbone.dif.dk>
	<1073531294.2304.18.camel@localhost.localdomain>
	<Pine.LNX.4.56.0401081032590.10083@jju_lnx.backbone.dif.dk>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason asked:
> Well, anything wrong in cleaning them [unsigned compare warnings] up?

It's more important that we write code that will fit in our limited
human brains than that we write code that will avoid spurious warnings
from gcc ('spurious' meaning warnings for code that gcc will correctly
compile anyway).

Or, see a couple months ago, in a thread with the Subject of:

  [PATCH] irda: fix type of struct irda_ias_set.attribute.irda_attrib_string.len

in which Linus wrote:
> That's why I hate the "sign compare" warning of gcc so much - it warns 
> about things that you CANNOT sanely write in any other way. That makes 
> that particular warning _evil_, since it encourages people to write crap 
> code.


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
