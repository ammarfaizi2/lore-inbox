Return-Path: <linux-kernel-owner+w=401wt.eu-S1754154AbWLXHCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbWLXHCK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 02:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbWLXHCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 02:02:10 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:32366 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754154AbWLXHCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 02:02:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=3hn0Bi60/9+PHhBMQ8O0loCFxdP18dgepumrOFyDKbOetZKLKPBlNAUrRKU5QzTSVaTL9DSPIE7qz2OV1gGq+DvdGwu6nX56v7sdpzWIZSHNDH0zELRzWFlM5nXxd5Ib/UtX074oIWNzlNwglASQEy69jFRJn9gBT+HudeksJLU=  ;
X-YMail-OSG: tZAjoUwVM1kwQQudp.iCKISL6iACg3hfgRuvO1YGN8ojkv952FxpvwJfiWhlyqteR2zZfbUG0n2njqNzly.ZDDVIoUr7Lg1wVsnIUqJTWDl4ImSLlUUr_BlD72ieR4Wi5lhah91elPg0wIfAc0ViS5bDsHBY0S4sP7c-
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Changes to PM layer break userspace
Date: Sat, 23 Dec 2006 23:02:05 -0800
User-Agent: KMail/1.7.1
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061222210937.GD3960@ucw.cz>
In-Reply-To: <20061222210937.GD3960@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612232302.06151.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 December 2006 1:09 pm, Pavel Machek wrote:
> Actually, if we noticed power/state during PM framework review, it
> would have been killed. It is just way too ugly.
> 
> > > > In contrast, the /sys/devices/.../power/state API has never had many
> > > > users beyond developers trying to test their drivers ...
> > > 
> > > It's used on every Ubuntu and Suse system,
> > 
> > Odd how the relevant Suse developers didn't mention any issues with
> > those files going away, any of the times problems with them were
> > discussed on the PM list.  Also, I have a Suse system that doesn't
> > use those files for anything ... maybe only newer release use it.
> 
> Not on *every* suse system. power/state is known to oops kernels, so
> it is only enabled when user explicitely asks for 'dangerous aggresive
> experimental power saving' or something like that.

So exactly what tool on Ubuntu uses this?  Without any "dangerous!
aggressive! experimental!" read-lights-siren-alarms-ringing alert level?


Seems to me anyone really desperate to put PCI devices into a low
power mode, without driver support at the "ifdown" level, would be
able just "rmmod driver; setpci".  Without risking software bugs.
