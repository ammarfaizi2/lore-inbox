Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVBQK61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVBQK61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 05:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVBQK61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 05:58:27 -0500
Received: from mail.charite.de ([160.45.207.131]:25741 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262271AbVBQK6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 05:58:23 -0500
Date: Thu, 17 Feb 2005 11:58:18 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Dale Blount <linux-kernel@dale.us>, linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.10-ac12 in kjournald (journal_commit_transaction)
Message-ID: <20050217105818.GS6680@charite.de>
Mail-Followup-To: Dale Blount <linux-kernel@dale.us>,
	linux-kernel@vger.kernel.org
References: <20050215145618.GP24211@charite.de> <20050216153338.GA26953@atrey.karlin.mff.cuni.cz> <20050216200441.GH19871@charite.de> <1108590885.17089.17.camel@dale.velocity.net> <20050216145548.53f67fec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050216145548.53f67fec.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:

> There have been a handful of reports - there's surely a race in there.
> 
> Unfortunately I've yet to see a report from which we can identify the
> offending line in the very large journal_commit_transaction() function.

:(

> 
> The best way to do that is to ensure that the kernel was built with
> CONFIG_DEBUG_INFO, note the offending EIP value, then do
> 
> # gdb vmlinux
> (gdb) l *0xc0<whatever>

I'm rebuilding the ac12 kernel which crashed on me after just one day
and will reboot it today.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
