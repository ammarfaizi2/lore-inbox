Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbUAPBZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUAPBZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:25:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46022 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265231AbUAPBZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:25:17 -0500
Date: Fri, 16 Jan 2004 01:25:11 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: GOTO Masanori <gotom@debian.or.jp>
Cc: arjanv@redhat.com, Steve Youngs <sryoungs@bigpond.net.au>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Increase recursive symlink limit from 5 to 8
Message-ID: <20040116012511.GI21151@parcelfarce.linux.theplanet.co.uk>
References: <E1AeMqJ-00022k-00@minerva.hungry.com> <2flllofnvp6.fsf@saruman.uio.no> <microsoft-free.87isjj0y1e.fsf@eicq.dnsalias.org> <1073814570.4431.3.camel@laptop.fenrus.com> <817jzsd8lg.wl@omega.webmasters.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817jzsd8lg.wl@omega.webmasters.gr.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 09:45:47AM +0900, GOTO Masanori wrote:
 
> But I still think 6 is too small from user level point of view, as
> Petter wrote.  The example is /usr/lib library links.  I got bug
> report which complained that a library want to use "bounce" link:
> 
> 	/usr/lib/liba -> /etc/alternatives/liba -> /usr/lib/another/libb.
> 
> If .so file uses major.minor scheme, then /usr/lib/liba.so links:
> 
> 	/usr/lib/liba.so -> /usr/lib/liba.so.2 -> /usr/lib/liba.so.2.3
> 
> and so on.  It can easily exceed 6 symlinks.  I think the correct fix
> is to make VFS not to overflow stacks.  Is it allowable change?

	You are quite welcome to submit clean patches that would do that.
So far all suggested "solutions" had turned out to be broken _and_ ugly.
