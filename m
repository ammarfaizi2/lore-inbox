Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWABUQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWABUQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWABUQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:16:28 -0500
Received: from mail.gmx.net ([213.165.64.21]:30882 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751015AbWABUQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:16:27 -0500
X-Authenticated: #527675
Message-ID: <43B98A19.8070002@gmx.de>
Date: Mon, 02 Jan 2006 21:16:25 +0100
From: Reinhard Nissl <rnissl@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SysReq & serial console
References: <43B8696B.2070303@gmx.de> <dpakp2$tip$3@sea.gmane.org> <20060102091808.GA11673@flint.arm.linux.org.uk>
In-Reply-To: <20060102091808.GA11673@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Russell King wrote:

>>Another wild guess: the syslog is still running and writes the output to
>>the log.
> 
> I don't think syslog can influence whether you see sysrq output via the
> console.  Nevertheless, try sysrq-8 before other sysrq functions.

On my SuSE 10 system, I find the following lines in /etc/syslog.conf:

# print most on tty10 and on the xconsole pipe
#
kern.warning;*.err;authpriv.none         /dev/tty10
kern.warning;*.err;authpriv.none        |/dev/xconsole

Changing tty10 to ttyS0 and restarting rcsyslog has no influence on the
output of SysReq commands, but obviously they now nolonger appear on
tty10. So what's the correct way to delegate the output to serial console?

PS: kernel command line: ... console=ttyS0,115200 console=tty0

BTW: a short update of my freeze issue:
- memtest86 revealed a bad memory location
- accidentially beeing at tty10 when the freeze happend and sysrq-p
showed that the atheros module got stuck
- exchanging RAM and disabling ath0 seems to cure the system for 39
minutes so far ;-)

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de

