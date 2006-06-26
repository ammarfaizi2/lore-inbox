Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWFZEUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWFZEUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 00:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWFZEUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 00:20:20 -0400
Received: from smtpauth04.mail.atl.earthlink.net ([209.86.89.64]:7810 "EHLO
	smtpauth04.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S932272AbWFZEUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 00:20:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=mindspring.com;
  b=SIk48TGOTBs2wFYbup03bRoSVy4tKGn8EqZADvJhRYjfxGaV13SKr5PETNhes6yd;
  h=Received:Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Date: Mon, 26 Jun 2006 00:20:13 -0400
From: Bill Fink <billfink@mindspring.com>
To: Harry Edmon <harry@atmos.washington.edu>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-Id: <20060626002013.55514734.billfink@mindspring.com>
In-Reply-To: <449F0570.2090001@atmos.washington.edu>
References: <4492D5D3.4000303@atmos.washington.edu>
	<44948EF6.1060201@atmos.washington.edu>
	<Pine.LNX.4.61.0606191638550.23553@ask.diku.dk>
	<200606191724.31305.ak@suse.de>
	<Pine.LNX.4.61.0606192017370.31662@ask.diku.dk>
	<449F0570.2090001@atmos.washington.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; powerpc-yellowdog-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: c598f748b88b6fd49c7f779228e2f6aeda0071232e20db4dc209a60dc5beaffe44c2a27f1374f8c2350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.55.21.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006, Harry Edmon wrote:

> I understand the saying "beggars can't be choosers", but I have heard nothing on 
> this issue since June 19th.  Does anyone have any ideas on what is going on?  Is 
> there more information I can collect that would help diagnose this problem?  And 
> again, thanks for any and all help!

Harry,

I'd suggest checking all the ethtool configuration settings
(ethtool -a, -c, -g, -k) and statistics (ethtool -S) for both
the working and problematic kernels, and then comparing them
to see if anything jumps out at you.  Also compare ifconfig
settings and dmesg output.  Check /proc/interrupts to see if
there is any difference with the interrupt routing.  Check
sysctl.conf and rc.local for any special system configuration
or device settings that might differ between the systems.

The one thing that has caused me a lot of network performance
issues on e1000 is having TSO enabled, so if that is enabled
(check with ethtool -k), then I'd try disabling it to see if
that helps.

					-Hope this helps

					-Bill
