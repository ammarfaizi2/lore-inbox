Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTEYKqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 06:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTEYKqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 06:46:52 -0400
Received: from mail.ithnet.com ([217.64.64.8]:49681 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261823AbTEYKqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 06:46:51 -0400
Date: Sun, 25 May 2003 12:58:11 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: willy@w.ods.org, gibbs@scsiguy.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-Id: <20030525125811.68430bda.skraw@ithnet.com>
In-Reply-To: <20030524111608.GA4599@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030524111608.GA4599@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003 13:16:08 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> > Hello Willy,
> > 
> > I will do that, but I am not so confident about this, because the box runs
> > X and a console oops output from nmi may as well not be visible nor written
> > to disk.
> 
> OK, I understand. Other options are : serial console (worked for me after
> several retries), remote syslogd (sometimes works if the system can still
> schedule a bit), or patches such as netconsole, which sends the logs to a
> remote host, and kmsgdump which tries to get them onto a floppy after a
> panic or a forced dump.
> 
> Regards,
> Willy

Hello all,

it did not take really long for rc3+aic20030520 to freeze - exactly one day.

Though I used nmi_watchdog there are no presentable outputs. As I expected the
screen simply is black and no messages are in any logfiles.
Again it froze while tar-ing about 80 GB of data onto an aic-driven SDLT. Data
is coming from IDE drive connected to a 3ware 7500-8 (though no raid
configuration). 

I conclude that rc2+aic20030502 was way better.

Ah yes, one more thing: I can ping the box, but keyboard, mouse, display is
dead and usually working processes stopped (like snmp).

Willy: I am willing to try a serial console setup (as it does not interfere
with X). I have tried this before with no luck. Can you provide some hints how
you got that working (yes, I read Documentation/serial-console.txt, but I could
not manage any output on the serial line).

Regards,
Stephan


