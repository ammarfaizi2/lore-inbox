Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTIXPI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 11:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbTIXPI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 11:08:29 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:31105 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261362AbTIXPI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 11:08:28 -0400
Date: Wed, 24 Sep 2003 16:08:18 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309241508.h8OF8ISB002016@81-2-122-30.bradfords.org.uk>
To: rjohnson@analogic.com
Subject: Re: Horiffic SPAM
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They are persistant, gang up, and will not give up until they are
> able to deliver the mail! When I firewall them, my network traffic
> ends up being continuous SYN floods

The ISP who supply this DSL connection have been rejecting connects to
their inbound SMTP server from unlisted IPs for ten minutes after the
initial connection attempt.  Retries after ten minutes are accepted,
and future connections are allowed immediately, unless the IP doesn't
make any connections for more than a week.

Apparently, it has reduced the volume of junk mail considerably, as
the 'virus' SMTP engines often don't bother to retry after getting a
4xx error code :-).  Obviously it delays genuine traffic coming
through that server slightly.

This may be a good solution to the problem for anyone who has control
of their own SMTP servers.

(Before anybody says that such greylisting by an ISP is irresponsible,
it's not in this case - unlike most DSL providers, they provide a real
static IP address block, (both v4 and v6), and fully configurable and
delegatable reverse DNS.  This means that there is no need to use
their SMTP server at all.  The most obvious setup is to run your own
primary SMTP server(s), and use theirs as a secondary.)

One theoretical solution to the whole junk mail problem that occurs to
me, would be for everybody to run a spoof open mail relay on port 25
of every IP under their control.  By that I mean a script that accepts
mail and claims that it will be delivered, but never delivers it.
Since the IPs running these spoof SMTP servers would never be listed
against an MX record anywhere, no genuine mail would go to them, only
junk.

Anybody sending junk mail via open relays they'd discovered via port
scanning would probably see a >99% reduction in the mails that
actually got through.  Presumably the companies who pay for the bulk
mail delivery would learn that their mails were not getting through,
and the business would cease to be profitable.

The only junk mail left would be from identifyable sources which is
_much_ easier to deal with.

Of course IPv6 will bring some of these benefits as hopefully ISPs
will assign static IP allocations, rather than dynamic ones.

John.
