Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274544AbRJAEKX>; Mon, 1 Oct 2001 00:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274537AbRJAEKO>; Mon, 1 Oct 2001 00:10:14 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36345 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274533AbRJAEKA>; Mon, 1 Oct 2001 00:10:00 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Sun, 30 Sep 2001 22:09:50 -0600
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com, jgarzik@mandrakesoft.com
Subject: Re: [patch] netconsole-2.4.10-B1
Message-ID: <20010930220950.K930@turbolinux.com>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdlab.org>, mingo@elte.hu,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com, jgarzik@mandrakesoft.com
In-Reply-To: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain> <3BB77591.C1349C09@osdlab.org> <3BB77FD7.696CFC58@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB77FD7.696CFC58@osdlab.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 30, 2001  13:25 -0700, Randy.Dunlap wrote:
> I'm interested in using netconsole early (during boot).
> Any problems doing that, other than getting module parameters
> to it?  I can fix that part.

I was thinking about this as well.  It should be relatively easy to allow
a line line "console=eth0,XX:XX:XX:XX:XX:XX,a.b.c.d" or similar.  The only
slight problem might be in configuring the interface early enough in the
boot process.  AFAIK (which isn't much in this area) the serial console
has special "console" code which allows it to be used very early in the
boot process.

You would obviously need to have the network driver compiled into the kernel
and not a module.  Maybe Ingo can hack something where it is possible
to initialize the network code very early in the boot process?

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

