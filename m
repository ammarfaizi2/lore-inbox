Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWHGRPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWHGRPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWHGRPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:15:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:18374 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750804AbWHGRPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:15:54 -0400
Date: Mon, 7 Aug 2006 10:15:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: nagar@watson.ibm.com, akpm@osdl.org, vatsa@in.ibm.com, mingo@elte.hu,
       nickpiggin@yahoo.com.au, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       haveblue@us.ibm.com
Subject: Re: [ProbableSpam] Re: [RFC, PATCH 0/5] Going forward with Resource
 Management - A cpu  controller
Message-Id: <20060807101518.aef1f06e.pj@sgi.com>
In-Reply-To: <44D765E3.9040206@sw.ru>
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
	<44D35794.2040003@sw.ru>
	<44D367F3.8060108@watson.ibm.com>
	<44D6EBEF.9010804@sw.ru>
	<20060807023025.2c44f3d1.pj@sgi.com>
	<44D765E3.9040206@sw.ru>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> we have a /proc which is very convenient for use from shell etc. but
> is not good for applications, not fast enough etc.
> moreover, /proc had always problems with locking, races and people tend to
> feel like they can change text presention of data, while applications parsing
> it tend to break.

Yes - one can botch a file system API.

One can botch syscalls, too.  Do you love 'ioctl'?

For some calls, the performance of a raw syscall is critical.  And
eventually, filesystem API's must resolve to raw file i/o syscalls.

But for these sorts of system configuration and management, the
difference in performance between file system API's and raw syscall
API's is not one of the decisive issues that determines success or
failure.

Getting a decent API that naturally reflects the long term essential
shape of the data is one of these decisive issues.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
