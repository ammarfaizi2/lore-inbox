Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263320AbVCKOXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbVCKOXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbVCKOXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:23:53 -0500
Received: from cpc4-cmbg4-4-0-cust135.cmbg.cable.ntl.com ([81.108.205.135]:25361
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S263320AbVCKOWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:22:25 -0500
Message-ID: <4231A94E.9020904@thekelleys.org.uk>
Date: Fri, 11 Mar 2005 14:21:02 +0000
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: CaT <cat@zip.com.au>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, pekkas@netcore.fi,
       yoshfuji@linux-ipv6.org
Subject: Re: ipv6 and ipv4 interaction weirdness
References: <20050311121655.GE14146@zip.com.au>
In-Reply-To: <20050311121655.GE14146@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT wrote:
> I just had some issues with ssh and trying to get it to bind to all ipv6
> and ipv4 addresses to it via :: and 0.0.0.0. The problem was that it'd
> only let one succeed. If 0.0.0.0:22 was successful then :: port 22 could
> not happen and neither could my ipv6 addy port 22 as it would get the
> 'address already in use' error from bind(). The reverse was also true.
> If it bound to :: port 22 then 0.0.0.0:22 would fail.
> 
> On the other hand if I got it to bind to each address individually then
> both ipv4 (2 addresses) and ipv6 (1 address) binds would succeed.
> 
> Maybe I'm just looking at it wrong but shouldn't ipv4 and ipv6 interfere
> with each other?
> 
> I'm using kernel 2.6.11-ac2 with OpenSSH_3.8.1p1 Debian-8.sarge.4,
> OpenSSL 0.9.7e 25 Oct 2004 and glibc 2.3.2 (debian version
> 2.3.2.ds1-20).
> 

A solution is to set the IPV6_V6ONLY sockopt on the IPv6 socket (or just 
use IPv6 sockets and their ability to accept IPv4 connections in a 
corner of the IPv6 address space).

It seems unlikely that a released ssh would have that problem, but I 
haven't checked.

Cheers,

Simon.


