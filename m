Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVAYSyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVAYSyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVAYSyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:54:44 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:48351 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262058AbVAYSyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:54:40 -0500
From: David Brownell <david-b@pacbell.net>
To: David Ford <david+challenge-response@blue-labs.org>
Subject: Re: Linux 2.6.11-rc2
Date: Tue, 25 Jan 2005 10:54:36 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200501232251.42394.david-b@pacbell.net> <41F6916F.7060000@blue-labs.org>
In-Reply-To: <41F6916F.7060000@blue-labs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251054.37053.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 January 2005 10:35 am, David Ford wrote:
> PMTU bug -- or better said, bad firewall admin who blocks all ICMP.

PMTU bug, sure -- but one that came late in RC2.  Remember:  same firewall
in both cases, but only RC2 breaks.  The ICMP packet has landed in
the RC2 system, which ignores it.  2.6.10 handled it correctly... I
suspect one of the TCP cleanups borked this.

My current workaround is "ifconfig eth0 mtu 1492" but that's not
something I'd expect to keep.

- Dave


> http://blue-labs.org/clue/mtu-mss.php
> 
> -david
> 
> David Brownell wrote:
> 
> >I'm seeing a problem with TCP as accessed through KMail (SuSE 9.2, x86_64).
> >But oddly enough, only for sending mail, not reading it; and not through
> >other (reading) applications... it's a regression with respect to rc1 and
> >earlier kernels.  Basically, it can only send REALLY TINY emails...
> >
> >  
> >
> 
