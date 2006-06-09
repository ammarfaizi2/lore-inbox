Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWFIJNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWFIJNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 05:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWFIJNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 05:13:54 -0400
Received: from odin2.bull.net ([129.184.85.11]:5831 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932336AbWFIJNx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Fri, 9 Jun 2006 05:13:53 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: markh@compro.net
Subject: Re: RT exec for exercising RT kernel capabilities
Date: Fri, 9 Jun 2006 11:15:50 +0200
User-Agent: KMail/1.7.1
Cc: linux-kerneL@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>
References: <448876B9.9060906@compro.net>
In-Reply-To: <448876B9.9060906@compro.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606091115.50576.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeudi 8 Juin 2006 21:12, Mark Hounschell wrote/a écrit :
> With the ongoing work being done to rt kernel enhancements by Ingo and friends,
> I would like to offer the use of a user land test (rt-exec). The rt-exec tests
> well the deterministic real-time capabilities of a computer. Maybe it could
> useful in some way to the effort or to anyone interested in making this type of
> determination about their kernel/computer.
> 
> A README describing the rt-exec can be found at
> ftp://ftp.compro.net/public/rt-exec/README
In the README, you say :
	...
	The exec must be run as root because of the use of mlockall,
	sched_setscheduler, and sched_setaffinity calls. Sorry but
	there has been no attempt to use the Linux CAPABILITIES API
	so that it could be run as regular user. 
	...

It's false if you use the LSM patch from here :
	http://sourceforge.net/projects/realtime-lsm/

-- 
Serge Noiraud
