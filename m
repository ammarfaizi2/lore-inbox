Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277493AbRJ3N16>; Tue, 30 Oct 2001 08:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278447AbRJ3N1s>; Tue, 30 Oct 2001 08:27:48 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:52220 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S277493AbRJ3N1d>; Tue, 30 Oct 2001 08:27:33 -0500
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 30 Oct 2001 05:04:35 -0800 (PST)
Subject: ipchains redirect failing in 2.4.5
Message-ID: <Pine.LNX.4.40.0110300454530.1329-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to track down a problem I have run into with 2.4.5

I have a firewall that has proxies listening on ports 1433-1437. If I
connect to these proxies on these ports I have no problems, however if I
put in an ipchains rule to redirect port 1433 on a second IP address to
port 1436 (for example) and then hammer the box with ab -n 500 -s 20 the
first 20 or so connections get through and then the rest timeout. doing
repeated netstat -an on the firewall during this process shows an inital
burst of 15 connections that get established, a pause, and then a handfull
more get established, followed by those 20 connections being in TIME_WAIT

again, connection to the same IP address on the real port the proxy is
listening on has no problems, it's only when going through the redirect
that it fails.

any suggestions, tuning paramaters I missed, or tests I need to run to
track this down?

David Lang
