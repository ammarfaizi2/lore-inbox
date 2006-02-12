Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWBLWn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWBLWn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 17:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWBLWn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 17:43:58 -0500
Received: from [65.103.28.221] ([65.103.28.221]:42393 "EHLO cinder.waste.org")
	by vger.kernel.org with ESMTP id S1750972AbWBLWn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 17:43:58 -0500
Date: Sun, 12 Feb 2006 16:43:40 -0600
From: Matt Mackall <mpm@selenic.com>
To: JaniD++ <djani22@dynamicweb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole problem
Message-ID: <20060212224340.GF10467@waste.org>
References: <00af01c62e4d$8de8c6c0$9d00a8c0@dcccs> <20060212174645.GA13703@waste.org> <017f01c63026$187a8150$9d00a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017f01c63026$187a8150$9d00a8c0@dcccs>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 11:45:52PM +0100, JaniD++ wrote:
> > On Fri, Feb 10, 2006 at 03:23:23PM +0100, JaniD++ wrote:
> > > Hello, list,
> > >
> > > I have a little problem, with netconsole.
> > > It does not work for me.
> > >
> > > On the "client":
> > >
> > > modprobe netconsole netconsole=@/,514@192.168.2.100/
> > > dmesg:
> > > netconsole: local port 6665
> > > netconsole: interface eth0
> > > netconsole: remote port 514
> > > netconsole: remote IP 192.168.2.100
> > > netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
> > > netconsole: local IP 192.168.2.50
> > > netconsole: network logging started
> > >
> > > (kernel: 2.6.15-rc5, and 2.6.16-rc1,2)
> > >
> > > On the server:
> > > ]# netcat -u -l -v -s 192.168.2.100 -p 514
> > > 192.168.2.100: inverse host lookup failed: Unknown host
> > > listening on [192.168.2.100] 514 ...
> > >
> > > And nothing comes.
> > >
> > > The firewall is off on both system.
> > > The ping comes from any direction.
> > >
> > > If i try the remote and local syslog, it works well, two.
> > > And in this case, the netlog only displays what the syslog is sends.
> > >
> > > What can be the problem?
> >
> > Perhaps your console log level is set too low. Fedora for instance is
> > very quiet by default.
> 
> Sorry, i was not clear enough....
> The system, what i want to debug is RedHat 9.0, with kernel 2.6.15, 2.6.16-*
> The syslog server is Fedora, and the syslog to syslog messages is works, but
> netconsole to syslog (and netconsole to netcat) is the problem, including
> the init-message!
> 
> At this time i try to receive with another redhat 9, but it looks like the
> netconsole did not working properly for me. :(

Netconsole logging level is based off the _console log level_, which
defaults to quiet on recent Redhat releases. If it doesn't show up on
the console, netconsole doesn't see it either.

-- 
Mathematics is the supreme nostalgia of our time.
