Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbTBHB42>; Fri, 7 Feb 2003 20:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbTBHB42>; Fri, 7 Feb 2003 20:56:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:1779 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266955AbTBHB41>;
	Fri, 7 Feb 2003 20:56:27 -0500
Date: Fri, 07 Feb 2003 17:57:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
Message-ID: <516500000.1044669465@flay>
In-Reply-To: <20030208015235.GA25432@wotan.suse.de>
References: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel> <p73ptq3bxh6.fsf@oldwotan.suse.de> <1044659375.18676.80.camel@w-jstultz2.beaverton.ibm.com> <20030208001844.GA20849@wotan.suse.de> <1044665441.18670.106.camel@w-jstultz2.beaverton.ibm.com> <20030208015235.GA25432@wotan.suse.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> However this doesn't work on systems w/o a synced TSC, so by simply
> 
> Why not? This shouldn't be performance critical and you can make 
> it monotonous with an additional variable + lock if backwards jumps
> should be a problem.
> 
> Also the variations between non synced TSCs should be far below 
> any watchdog's radar screen.

Not true. They'll drift further and further apart over time.
Even a 0.01% crystal difference will eventually kill you.

And if that isn't bad enough think about what happens when I run 180 MHz
processors in one node, and 900MHz in another.

You really can't make any assumptions about TSC sync on boxes where
they're not synced.

M.

