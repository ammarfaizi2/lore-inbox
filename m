Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUGYU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUGYU25 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUGYU25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 16:28:57 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:967 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264386AbUGYU2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 16:28:15 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: changing ethernet devices, new one stops cold at iptables
Date: Sun, 25 Jul 2004 16:28:14 -0400
User-Agent: KMail/1.6
References: <Pine.LNX.4.44.0407251149290.25333-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0407251149290.25333-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407251628.14604.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.57.16] at Sun, 25 Jul 2004 15:28:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 July 2004 05:50, Henrik Nordstrom wrote:
>On Thu, 22 Jul 2004, Gene Heskett wrote:
>> I can ping the firewall, and I can ssh into it, so that part of
>> the network is fine, I just cannot get past iptables in the
>> firewall when eth0 is the nforce hardware, which has a different
>> MAC address.
>
>Have you verified that the routing got correctly set up on the new
> box?
>
>   ip ro ls
>
>The usual cause to the symptoms you describe is that the default
> route has gone missing or is invalid.

The routing was good, showing the fireall as the default gateway 
address.

In this case, the fix was to reboot the firewall so that its arp 
tables got refreshed to match the new MAC address of the onboard 
nforce (forcedeth) nic.  Once that was done, everything was peachy.

Thanks, I appreciate the reply, Henrik.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
