Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbUKDO0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbUKDO0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbUKDO0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:26:21 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:46767 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262233AbUKDOX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:23:56 -0500
Date: Thu, 4 Nov 2004 15:26:20 +0100
From: DervishD <lkml@dervishd.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Ian Campbell <icampbell@arcom.com>,
       Jan Knutar <jk-lkml@sci.fi>, Tom Felker <tfelker2@uiuc.edu>
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104142620.GA23973@DervishD>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org, Ian Campbell <icampbell@arcom.com>,
	Jan Knutar <jk-lkml@sci.fi>, Tom Felker <tfelker2@uiuc.edu>
References: <200411030751.39578.gene.heskett@verizon.net> <200411040739.01699.gene.heskett@verizon.net> <1099573266.2856.40.camel@icampbell-debian> <200411040907.22684.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200411040907.22684.gene.heskett@verizon.net>
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
> Possibly, but OTOH,
> [root@coyote root]#  cat /proc/sys/kernel/sysrq
> 0
> 
> And no, I'm not turning it off anyplace in the boot proceedure.  An
> 'echo 1 >/proc/sys/kernel/sysrq', and repeating the keypresses now
> gets a boatload of stuff in the logs, but nothing on the console.

    Well, the stuff goes to the logs and not the console because of
the console log level. You can change that using proc, too. Look in
/proc/sys/kernel/printk (well, at least under 2.4.x). You'll see
four numbers. The first one is the console loglevel. Any message
directed to syslog with a priority higher than this number will be
printed in the console. Otherwise they won't.

    The second number is the default message level. Any message
without a priority will get this priority.

    The third number is the highest value you can assign to the first
number (the console loglevel).

    The fourth number is the default value for the first number.

    The interesting number for you is the first one. Set it to a
correct value for you (see syslog(2) to see what the numbers mean).

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
