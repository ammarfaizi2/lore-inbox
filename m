Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268095AbTB1SVM>; Fri, 28 Feb 2003 13:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268096AbTB1SVM>; Fri, 28 Feb 2003 13:21:12 -0500
Received: from ns.suse.de ([213.95.15.193]:50956 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268095AbTB1SVL>;
	Fri, 28 Feb 2003 13:21:11 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 420] New: Divide by zero (/proc/sys/net/ipv4/neigh/DEV/base_reachable_time)
References: <27440000.1046453828@[10.10.2.4].suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Feb 2003 19:31:31 +0100
In-Reply-To: "Martin J. Bligh"'s message of "28 Feb 2003 18:41:31 +0100"
Message-ID: <p733cm86yv0.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:
> 
>     echo 0 > /proc/sys/net/ipv4/neigh/DEV/base_reachable_time
> 
>   But neigh_rand_reach_time() divide by its argument.
> 
>     unsigned long neigh_rand_reach_time(unsigned long base)
>     {
> 	return (net_random() % base) + (base>>1);
>     }

Don't do that then. The sysctl is root-only. There are lots of ways to
break the system by writing bogus values into root only configuration
options. That is why they are root only

I would close the report as WONTFIX.

-Andi
