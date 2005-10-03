Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933210AbVJCRQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933210AbVJCRQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933208AbVJCRQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:16:06 -0400
Received: from hera.kernel.org ([140.211.167.34]:60840 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S933206AbVJCRQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:16:05 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Connection reset by peer - TCP window size oddity ?
Date: Mon, 3 Oct 2005 10:16:11 -0700
Organization: OSDL
Message-ID: <20051003101611.43714e53@dxpl.pdx.osdl.net>
References: <Pine.GSO.4.61.0510031241580.29231@scorpio.gold.ac.uk>
	<87r7b2k6de.fsf@newton.gmurray.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1128359751 4240 10.8.0.74 (3 Oct 2005 17:15:51 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 3 Oct 2005 17:15:51 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.14 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Oct 2005 15:44:13 +0100
Graham Murray <graham@gmurray.org.uk> wrote:

> Martin Drallew <m.drallew@fatsquirrel.org> writes:
> 
> > A tcpdump follows and, unless I'm misunderstanding the output (quite
> > possible) it looks like the kernel is sending outside of the peer's
> > TCP window, to which the peer responds by resetting the connection.
> 
> I think that you have overlooked one detail in the output. Both
> systems have declared window scaling of 2, so when otter sets the
> window size of 1984 in the packet it is actually advertising a window
> of 7936, which you are not exceeding. You do not say what type of
> system otter is (or what OS it is running), so one explanation is that
> otter has just mirrored your 'wscale 2' in its SYN-ACK without
> actually meaning it.

So you have a firewall in between the systems? There have been firewall's
that strip off the window size option, and this causes all sorts of
nasty problems like this.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
