Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWGKUCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWGKUCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWGKUCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:02:49 -0400
Received: from mxsf18.cluster1.charter.net ([209.225.28.218]:55193 "EHLO
	mxsf18.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751213AbWGKUCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:02:48 -0400
X-IronPort-AV: i="4.06,230,1149480000"; 
   d="scan'208"; a="387608855:sNHT20976968"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17588.997.688135.786150@stoffel.org>
Date: Tue, 11 Jul 2006 16:02:45 -0400
From: "John Stoffel" <john@stoffel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6.18-rc1-mm1 - bad serial port count messages
In-Reply-To: <20060711185630.GA1240@flint.arm.linux.org.uk>
References: <17587.42397.168635.821696@stoffel.org>
	<20060711185630.GA1240@flint.arm.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell> On Tue, Jul 11, 2006 at 09:20:29AM -0400, John Stoffel wrote:
>> I'm getting the following messages in dmesg:
>> 
>> uart_close: bad serial port count; tty->count is 1, state->count is 0
>> uart_close: bad serial port count for ttyS0: -1
>> uart_close: bad serial port count for ttyS0: -1

Russell> I assume that it's 100% reproducable, and doesn't happen with
Russell> mainline?

Not sure, haven't rebooted yet to make sure it happens again.  The
hardware is a Dell Dimension 630, Dual Xeon PIII 550mhz, 768mb of
RAM.  It's been my main machine for a number of years now.  

Russell> I'm not aware of any serial core patches in -mm which would
Russell> produce this type of breakage - maybe there's something funny
Russell> with the tty layer in that it's trying to close the port more
Russell> times than it's been opened...  Hmm.

I thought I saw something float by where someone had raised some new
locking or count variables?  I dunno... I'll work on it tonight and
see what happens after another reboot.

John
