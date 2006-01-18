Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWARBmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWARBmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 20:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWARBmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 20:42:47 -0500
Received: from stinky.trash.net ([213.144.137.162]:42638 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751277AbWARBmq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 20:42:46 -0500
Message-ID: <43CD9CDA.6030509@trash.net>
Date: Wed, 18 Jan 2006 02:41:46 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Linux 2.6.16-rc1
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <200601172106.k0HL6LMW008241@turing-police.cc.vt.edu>
In-Reply-To: <200601172106.k0HL6LMW008241@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 17 Jan 2006 00:19:56 PST, Linus Torvalds said:
> 
> 
>>And largish networking updates: there's a "common netfilter" setup now, 
>>which you'll notice when you do "make config" or equivalent, since a lot 
>>of the netfilter rules now work on ipv4 and/or ipv6 rather than having 
>>separate (and duplicate) versions for each.
> 
> 
> Hooray! Finally. ;)
> 
> Does this require modprobing of the modules by hand, or is there a version
> of iptables in the pipe that knows how to do this?  I checked the CVS snapshot
> directory on ftp.netfilter.org last night, and the latest one there didn't
> know about this yet.

The modules have aliases for their old names, so they should get
autoloaded. The matches and targets that didn't exist for IPv6
before need new extensions in userspace before they can be used
though.
