Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbTD3TPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbTD3TPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:15:49 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:26802 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262341AbTD3TPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:15:48 -0400
Date: Wed, 30 Apr 2003 21:28:09 +0200
From: bert hubert <ahu@ds9a.nl>
To: P?l Halvorsen <paalh@ifi.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile
Message-ID: <20030430192809.GA8961@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	P?l Halvorsen <paalh@ifi.uio.no>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no> <20030430165103.GA3060@outpost.ds9a.nl> <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 09:12:17PM +0200, P?l Halvorsen wrote:

> It could be useful for applications like streaming video where other
> protocols on top provide additional functionality or in a multicast
> session where TCP migth not be appropriate.

sendfile on UDP would try to send gigabits per second over ppp0...

> But should not the 2.4.X kernels have support for chained sk_buffs (like
> the BSD mbufs) meaning that support for scatter-gatter I/O from the NIC
> should be unneccessary to support zero-copy (i.e., NO in-memory data
> copy operations)?

No clue what you mean over here. Zero copy means different things to
different people. Sendfile eliminates the 'read(to buffer);write(buffer to
network);' copy. 

Some network drivers again may eliminate the 'copy_with_checksum()' step,
allowing minus-one-copy, in zerocopy reference frame.

Regards,

bert


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
