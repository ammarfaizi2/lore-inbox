Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbUKCT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUKCT3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbUKCTZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:25:45 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:61056 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261817AbUKCTYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:24:14 -0500
Date: Wed, 3 Nov 2004 20:26:48 +0100
From: DervishD <lkml@dervishd.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041103192648.GA23274@DervishD>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031147.14179.gene.heskett@verizon.net> <20041103174459.GA23015@DervishD> <200411031353.39468.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200411031353.39468.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Gene :)

 * Gene Heskett <gene.heskett@verizon.net> dixit:
> >    Then the children are reparented to 'init' and 'init' gets rid
> > of them. That's the way UNIX behaves.
> Unforch, I've *never* had it work that way.  Any dead process I've 
> ever had while running linux has only been disposable by a reboot.

    Well, you know, shit happens... Anyway, could you define 'dead'?
Because if you're talking about zombies whose parent dies, they're
killable easily: just wait until init reaps them (usually in less
than 5 minutes since they dead). If you are talking about zombies who
has their parent alive, then it's a bug in the application, not the
kernel. In fact I wouldn't like if the kernel reaps my children
before I do, just in case I want to do something.

    If you're talking about unkillable processes (those stuck in
disk-sleep state), you're right: only rebooting can kill them
(although sometimes they go out of D state and die normally). Bad
luck for you if any dead process you've ever had while running linux
has been of this kind :(

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
