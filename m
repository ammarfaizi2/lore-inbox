Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262014AbSIYPmz>; Wed, 25 Sep 2002 11:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262015AbSIYPmz>; Wed, 25 Sep 2002 11:42:55 -0400
Received: from tempest.prismnet.com ([209.198.128.6]:6670 "EHLO
	tempest.prismnet.com") by vger.kernel.org with ESMTP
	id <S262014AbSIYPmy>; Wed, 25 Sep 2002 11:42:54 -0400
From: Troy Wilson <tcw@tempest.prismnet.com>
Message-Id: <200209251547.g8PFlsrR013807@tempest.prismnet.com>
Subject: SPECWeb99 Data -- tcp-wakeups
To: akpm@digeo.com
Date: Wed, 25 Sep 2002 10:47:53 -0500 (CDT)
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       lse-tech@lists.sourceforge.net
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   ********************************************************************
   *  SPEC(tm) and the benchmark name SPECweb(tm) are registered      *
   *  trademarks of the Standard Performance Evaluation Corporation.  *
   *  This benchmarking was performed for research purposes only,     *
   *  and is non-compliant, with the following deviations from the    *
   *  rules -                                                         *
   *                                                                  *
   *    1 - It was run on hardware that does not meed the SPEC        *
   *        availability-to-the-public criteria.  The machine is      *
   *        an engineering sample.                                    *
   *                                                                  *
   *    2 - access_log wasn't kept for full accounting.  It was       *
   *        being written, but deleted every 200 seconds.             *
   ********************************************************************

  I've done some testing with SPECWeb99 on 2.5.35 mm1 with and without 
the tcp-wakeups patch backed out.  The addition of tcp-wakeups makes a 2%
improvement in performance.

                           mm1              mm1 without tcp-wakeup
                         -----------------------------------------
Simultaneous connections   3049             2982


  The system is an 8-way, 900MHz, Profusion-based P3 box with 32GB memory.
It's connected to 16 SPECWeb client machines via 4 e1000 gigabit adapters.
I'm using Apache 2.0.36 as the webserver.

- Troy



