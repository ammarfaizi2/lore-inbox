Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUAHPjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265384AbUAHPjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:39:20 -0500
Received: from DSL022.labridge.com ([206.117.136.22]:22290 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S265383AbUAHPjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:39:18 -0500
Subject: Re: [PATCH] mm/slab.c remove impossible <0 check - size_t is not
	signed - patch is against 2.6.1-rc1-mm2
From: Joe Perches <joe@perches.com>
To: Paul Jackson <pj@sgi.com>
Cc: Jesper Juhl <juhl@dif.dk>, juhl-lkml@dif.dk, linux-kernel@vger.kernel.org,
       markhe@nextd.demon.co.uk, andrea@e-mind.com, manfred@colorfullife.com
In-Reply-To: <20040108021658.0a8aaccc.pj@sgi.com>
References: <Pine.LNX.4.56.0401080204060.9700@jju_lnx.backbone.dif.dk>
	 <1073531294.2304.18.camel@localhost.localdomain>
	 <Pine.LNX.4.56.0401081032590.10083@jju_lnx.backbone.dif.dk>
	 <20040108021658.0a8aaccc.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1073576236.2340.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Jan 2004 07:37:16 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-08 at 02:16, Paul Jackson wrote:
> Jason asked:
> > Well, anything wrong in cleaning them [unsigned compare warnings] up?

In this case the warning is not unsigned compare but
"comparison of .* is always [true|false]".

This sort of code generally makes me think someone did something wrong,
not just that the person added additional unnecessary checking.


