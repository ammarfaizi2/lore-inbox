Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbVAFQMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVAFQMC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVAFQMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:12:01 -0500
Received: from dialpool1-19.dial.tijd.com ([62.112.10.19]:30088 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262889AbVAFQL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:11:56 -0500
From: Jan De Luyck <lkml@kcore.org>
To: "Steve Iribarne" <steve.iribarne@dilithiumnetworks.com>
Subject: Re: ARP routing issue
Date: Thu, 6 Jan 2005 17:11:57 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <B8561865DB141248943E2376D0E85215846787@DHOST001-17.DEX001.intermedia.net>
In-Reply-To: <B8561865DB141248943E2376D0E85215846787@DHOST001-17.DEX001.intermedia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501061711.59301.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 January 2005 17:06, Steve Iribarne wrote:
> Hi Jan,
>
>
> -> default gateway is set to 10.0.22.1, on eth0.
> ->
> -> Problem is, if I try to ping from another network
> -> (10.216.0.xx) to 10.0.24.xx, i see the following ARP request:
> ->
> -> arp who-has 10.0.22.1 tell 10.0.24.xx
> ->
>
> You see that coming out the eth0 interface??
>
> If that is the case it is most definately wrong.  Assuming that your
> masks are setup properly.  But I haven't worked on the 2.4 kernel for a
> long time so I'm not so sure if what you are seeing is a bug that has
> been fixed.

The network information is:
eth0 10.0.22.xxx mask 255.255.255.0
eth1 10.0.24.xxx mask 255.255.255.0

routing:
10.0.22.0 0.0.0.0 255.255.255.0 eth0
10.0.24.0 0.0.0.0 255.255.255.0 eth1
0.0.0.0  10.0.22.1 0.0.0.0  eth0

Jan

-- 
If a man slept by day, he had little time to work.  That was a
satisfying notion to Escargot.
  -- "The Stone Giant", James P. Blaylock
