Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932589AbWIVQvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWIVQvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWIVQvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:51:14 -0400
Received: from palrel12.hp.com ([156.153.255.237]:47266 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S932562AbWIVQvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:51:13 -0400
Message-ID: <4514147D.5040803@hp.com>
Date: Fri, 22 Sep 2006 09:51:09 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.7.13) Gecko/20060601
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       David Miller <davem@davemloft.net>, master@sectorb.msk.ru, hawk@diku.dk,
       harry@atmos.washington.edu, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
References: <200609181850.22851.ak@suse.de>	<20060919.124751.24100694.davem@davemloft.net>	<20060922153517.GB24866@ms2.inr.ac.ru> <200609221743.40053.ak@suse.de>
In-Reply-To: <200609221743.40053.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That came from named. It opens lots of sockets with SIOCGSTAMP.
> No idea what it needs that many for.

IIRC ISC BIND named opens a socket for each IP it finds on the system. 
Presumeably in this way it "knows" implicitly the destination IP without 
using platform-specific recvfrom/whatever extensions and gets some 
additional parallelism in the stack on SMP systems.

Why it needs/wants the timestamps I've no idea, I don't think it gets 
them that way on all platforms.  I suppose the next time I do some named 
benchmarking I can try to take a closer look in the source.

rick jones
