Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbTBHBm4>; Fri, 7 Feb 2003 20:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbTBHBm4>; Fri, 7 Feb 2003 20:42:56 -0500
Received: from ns.suse.de ([213.95.15.193]:34571 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266953AbTBHBmz>;
	Fri, 7 Feb 2003 20:42:55 -0500
Date: Sat, 8 Feb 2003 02:52:35 +0100
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
Message-ID: <20030208015235.GA25432@wotan.suse.de>
References: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel> <p73ptq3bxh6.fsf@oldwotan.suse.de> <1044659375.18676.80.camel@w-jstultz2.beaverton.ibm.com> <20030208001844.GA20849@wotan.suse.de> <1044665441.18670.106.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044665441.18670.106.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However this doesn't work on systems w/o a synced TSC, so by simply

Why not? This shouldn't be performance critical and you can make 
it monotonous with an additional variable + lock if backwards jumps
should be a problem.

Also the variations between non synced TSCs should be far below 
any watchdog's radar screen.

-Andi
