Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbRA2WhY>; Mon, 29 Jan 2001 17:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbRA2WhP>; Mon, 29 Jan 2001 17:37:15 -0500
Received: from mail4.svr.pol.co.uk ([195.92.193.211]:43018 "EHLO
	mail4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130792AbRA2WhD>; Mon, 29 Jan 2001 17:37:03 -0500
Date: Sun, 28 Jan 2001 19:48:29 +0000
To: Matthew Fredrickson <matt@frednet.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP/Modem connection problems starting somewhere between 2.2.14(maybe 15) and 2.2.18
Message-ID: <20010128194828.A13179@wyvern>
Reply-To: adrian.bridgett@iname.com
Mail-Followup-To: Matthew Fredrickson <matt@frednet.dyndns.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010124173038.A23669@frednet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010124173038.A23669@frednet.dyndns.org>; from matt@frednet.dyndns.org on Wed, Jan 24, 2001 at 05:30:38PM -0600
From: Adrian Bridgett <adrian.bridgett@iname.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 17:30:38 -0600 (+0000), Matthew Fredrickson wrote:
> I'm not positive if this is a bug, I'm only able to confirm this from one
> other source.  Somewhere between (I can't remember exactly which kernel my
> server started on) ~2.2.14(or 15) and 2.2.18 my ppp connection
> periodically hangs and I have to restart the connection.  My situation is
[snip]

Ditto.  Using evil winmodem here and Debian (ppp-2.4.0f-1).  2.2.19pre3 at
the moment but it's been happening for a while.  Things seemed better when I
turned on default-asyncmap, however it still occasionally goes belly up
(almost _always_ when scping files out (uploading Debian packages)).  Last
time I checked it also happend with my 28.8k USB modem (a normal modem, that
one).

I've found a magic fix and when I've got time I'll try and burrow though the
pppd source to try and find out why.  The magic fix? Turn on recording in
pppd (i.e. add "record /tmp/foo"  to /etc/ppp/options).  I'd be interested
if it fixes it for you.

Adrian

Email: adrian.bridgett@iname.com
Windows NT - Unix in beta-testing. GPG/PGP keys available on public key servers
Debian GNU/Linux  -*-  By professionals for professionals  -*-  www.debian.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
