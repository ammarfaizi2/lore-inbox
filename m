Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTGBHmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 03:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTGBHmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 03:42:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35850 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262984AbTGBHmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 03:42:36 -0400
Date: Wed, 2 Jul 2003 08:56:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
       Bernardo Innocenti <bernie@develer.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Message-ID: <20030702085647.B30638@flint.arm.linux.org.uk>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Bernardo Innocenti <bernie@develer.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <200307020232.20726.bernie@develer.com> <20030701173612.280d1296.akpm@digeo.com> <200307020424.47629.bernie@develer.com> <16130.21283.122787.362837@wombat.chubb.wattle.id.au> <20030702055759.GJ3040@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030702055759.GJ3040@dualathlon.random>; from andrea@suse.de on Wed, Jul 02, 2003 at 07:57:59AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 07:57:59AM +0200, Andrea Arcangeli wrote:
> this doesn't even sounds safe. If it's just for printing not a big deal,

It used to be only used in vsprintf.  However, now it features in the
kernels time code, and that rather screws things up if its implemented
as a 32 by 32 operation.

Therefore, if architectures want a stable time subsystem, all
architectures must provide a do_div() which is a 64 by 32 operation.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

