Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbTLFKup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 05:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbTLFKup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 05:50:45 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:464 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S264974AbTLFKun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 05:50:43 -0500
Message-ID: <3FD1B47E.3050600@cyberone.com.au>
Date: Sat, 06 Dec 2003 21:50:38 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Craig Thomas <craiger@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Prcess scheduler Imiprovements in 2.6.0-test9
References: <1070650522.13254.28.camel@bullpen.pdx.osdl.net>
In-Reply-To: <1070650522.13254.28.camel@bullpen.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Craig Thomas wrote:

>OSDL has been running peformance tests with hackbench to measure the
>improvment of the scheduler, compared with LInux 2.4.18.  We ran the
>test on our Scalable Test Platform on different system sizes.  The
>results obtained seem to show that the 2.6 scheduler is more
>efficient and allows for greater scalability on larger systems.
>See http://marc.theaimsgroup.com/?l=linux-kernel&m=100805466304516&w=2
>for a description of hackbench.
>
>The set of data below shows an average time of five hackbench runs
>for each set of groups.  Linux 2.6.0-test9 clearly shows significan
>improvement in the completion times.
>
>Test set 1: Performance of hackbench
>
>(times are in seconds, lower number is better)
>
>number of groups     50     100     150     200
>--------------------------------------------------
>1 CPU
>   2.4.18          15.52   37.63   74.34   110.62
>   2.6.0-test9      9.91   17.86   27.55    39.77
>--------------------------------------------------
>2 CPUs
>   2.4.18          10.50   30.42   64.26   112.46
>   2.6.0-test9      7.44   13.45   19.68    26.68
>--------------------------------------------------
>4 CPUs
>   2.4.18           7.07   22.75   54.10   101.45
>   2.6.0-test9      5.16   9.25    13.64    18.65
>--------------------------------------------------
>8 CPUs
>   2.4.18           7.02   24.63   61.48   114.93
>   2.6.0-test9      4.08   7.15    10.31    13.84
>--------------------------------------------------
>

Hi Craig,
The numbers here are very impressive. Is there is an easy way
to make a table of results like this with STP? What is the
exact parameter line you pass to hackbench to get this?
These are results from a run with my scheduler patch on the
8-way. Not sure if they're comparable but if so they are a
small improvement.

20 		1.69
40 		2.54
60 		3.41
80 		4.38
100 		5.44



