Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbUDQE52 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 00:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUDQE51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 00:57:27 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:26866 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263631AbUDQE50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 00:57:26 -0400
Message-ID: <4080B8F4.80003@nortelnetworks.com>
Date: Sat, 17 Apr 2004 00:56:20 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS and kernel 2.6.x
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <20040416144433.GE2253@logos.cnet>  <408001E6.7020001@treblig.org> <1082132015.2581.30.camel@lade.trondhjem.org> <5FF89D68-8FD9-11D8-988A-000A958E35DC@fhm.edu>
In-Reply-To: <5FF89D68-8FD9-11D8-988A-000A958E35DC@fhm.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:

> Great you want to help here. So I've a system which is NFS root using a
> 3c940 gigabit onboard NIC on kernel 2.6.5 and which is dead fish in the
> water somewhere in between 10 seconds and 5 minutes after boot using
> NFS over UDP. The last thing I see are 3 or 4 messages of the type:

If this is an issue, it might make sense to have root be a tmpfs 
filesystem, and then have specific network mounts.  Note--don't make 
"/var/log" network mounted, various apps default to trying to check for 
files there--if the server goes away, you can't log in/out.

Chris
