Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271777AbRI2Whm>; Sat, 29 Sep 2001 18:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271719AbRI2Whd>; Sat, 29 Sep 2001 18:37:33 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:32504 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271777AbRI2WhS>; Sat, 29 Sep 2001 18:37:18 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Sat, 29 Sep 2001 16:37:00 -0600
To: Pekka Savola <pekkas@netcore.fi>
Cc: Ingo Molnar <mingo@elte.hu>, "Randy.Dunlap" <rddunlap@osdlab.org>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [patch] netconsole-2.4.10-B1
Message-ID: <20010929163659.J930@turbolinux.com>
Mail-Followup-To: Pekka Savola <pekkas@netcore.fi>,
	Ingo Molnar <mingo@elte.hu>, "Randy.Dunlap" <rddunlap@osdlab.org>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain> <Pine.LNX.4.33.0109291936500.17020-100000@netcore.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109291936500.17020-100000@netcore.fi>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 29, 2001  19:40 +0300, Pekka Savola wrote:
> Speaking of which, would it be too big a burden (or is it supported
> already), that the oopses or dumps would be sent off to an off-link syslog
> server?
> 
> This would ease the use in occasions where you don't expect a crash (ie:
> no listener in local network), but do log on remote syslogd's
> considerably.

That was in the patch I just sent to Ingo - the "client" logs all of the
messages to syslog.  However, it is not "perfect" yet, in that you need
to be able to select whether or not you really want it sent to syslog,
and for some reason, even though I have LOG_KERN as the type, it only
gets logged to /var/log/messages and not /var/log/kern.log (on my system
at least) (this was in the TODO list, which I'm not in the position to
work on right now).

For crash dumps and such (which you don't want sent to syslog) it may be
useful to have a different message type (with its own offset numbers),
so the client knows to save it to a different file, for example, and will
handle out-of-order messages, and sparse memory dumps.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

