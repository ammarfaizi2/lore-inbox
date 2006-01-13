Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWAMRzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWAMRzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWAMRzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:55:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422752AbWAMRzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:55:42 -0500
Date: Fri, 13 Jan 2006 09:55:33 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: WCONF, netlink based WE replacement.
Message-ID: <20060113095533.5d5df015@dxpl.pdx.osdl.net>
In-Reply-To: <200601121824.02892.mbuesch@freenet.de>
References: <200601121824.02892.mbuesch@freenet.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 18:24:02 +0100
Michael Buesch <mbuesch@freenet.de> wrote:

> This is an attempt to rewrite the Wireless Extensions
> userspace API, using netlink sockets.
> There should also be a notification API, to inform
> userspace for changes (config changes, state changes, etc).
> It is not implemented, yet.
> 
> This is against the devicescape stack.
> This patch is not to be used, but only to be commented on. ;)
> Basically I would like comments on the API definition
> in wconf.h
> 

1. You will need more documentation, eventually in Documentation directory.

2. Is there 1:1 relationship between ieee80211_device and net_device or 
    N net_devices per ieee80211_device?

3. Don't put a version number on the protocol messages. The way to
   us netlink is to us Type Length Variable structures. And write the
   code to ignore unknown types.  Once you decide on a particular Type
   then it has to be frozen for ABI compatibility.  The version numbering
   in the WE API is part of the problem

4. What about non-ieee80211 devices? With the growth of (mostly proprietary)
   cell phone carrier wireless, you don't want to shut out that.
