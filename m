Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265891AbUGHHoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbUGHHoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUGHHoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:44:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29971 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265891AbUGHHoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 03:44:23 -0400
Date: Thu, 8 Jul 2004 08:44:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Rolland <rol@as2917.net>
Cc: "'Bernd Eckenfels'" <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Init single and Serial console : How to ?
Message-ID: <20040708084419.A13706@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Rolland <rol@as2917.net>,
	'Bernd Eckenfels' <ecki-news2004-05@lina.inka.de>,
	linux-kernel@vger.kernel.org
References: <200407041032.i64AWTX21222@tag.witbe.net> <200407080532.i685WpX28901@tag.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200407080532.i685WpX28901@tag.witbe.net>; from rol@as2917.net on Thu, Jul 08, 2004 at 07:32:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 07:32:45AM +0200, Paul Rolland wrote:
> Got this one working :
> 
> LILO: linux init=/sbin/sulogin /dev/ttyS0
> 
> It finally asked me to enter root password, I did my maintenance, 
> and then...
> /sbin/reboot did nothing
> leaving the shell (exit) said :
> Attempting to kill init
> Panic, will reboot in 30 seconds.
> (or something like that), but it didn't restart, and I had to reboot
> the machine...
> Is this the expected behaviour ?

Yes, since you exited the process which was pretending to be the init
program.  Basically, whatever program is pretending to be init must
never exit or be killed off - it's special.

You probably wanted to do /sbin/reboot -f

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
