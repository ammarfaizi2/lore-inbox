Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbTBHCHL>; Fri, 7 Feb 2003 21:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbTBHCHL>; Fri, 7 Feb 2003 21:07:11 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11442 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266961AbTBHCHK>;
	Fri, 7 Feb 2003 21:07:10 -0500
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20030208015235.GA25432@wotan.suse.de>
References: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
	 <p73ptq3bxh6.fsf@oldwotan.suse.de>
	 <1044659375.18676.80.camel@w-jstultz2.beaverton.ibm.com>
	 <20030208001844.GA20849@wotan.suse.de>
	 <1044665441.18670.106.camel@w-jstultz2.beaverton.ibm.com>
	 <20030208015235.GA25432@wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1044670483.21642.18.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Feb 2003 18:14:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-07 at 17:52, Andi Kleen wrote:
> > However this doesn't work on systems w/o a synced TSC, so by simply
> 
> Why not? This shouldn't be performance critical and you can make 
> it monotonous with an additional variable + lock if backwards jumps
> should be a problem.
> 

That sounds horrible! The extra locking and variable reading is going to
kill most of the performance concerns you have about reading an
alternate time source. 

I'm not sure I understand your resistance to using an alternate clock
for get_cycles(). Could you better explain your problem with it?

thanks
-john


