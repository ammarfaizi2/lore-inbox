Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264341AbTKZUmb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264342AbTKZUma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:42:30 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:50828 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S264341AbTKZUlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:41:36 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: amanda vs 2.6
Date: Wed, 26 Nov 2003 15:41:35 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <Pine.LNX.4.58.0311261202050.1524@home.osdl.org> <20031126200754.GU8039@holomorphy.com>
In-Reply-To: <20031126200754.GU8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311261541.35914.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.54.127] at Wed, 26 Nov 2003 14:41:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 November 2003 15:07, William Lee Irwin III wrote:
>On Wed, 26 Nov 2003, William Lee Irwin III wrote:
>>> Okay, then we need to figure out what the hung process was doing.
>>> Can you find its pid and check /proc/$PID/wchan?
>
>On Wed, Nov 26, 2003 at 12:04:56PM -0800, Linus Torvalds wrote:
>> I've seen this before, and I'll bet you 5c (yeah, I'm cheap) that
>> it's trying to log to syslogd.
>> And syslogd is stopped for some reason - either a bug, a mistaken
>> SIGSTOP, or simply because the console has been stopped with a
>> simple ^S. That won't stop "su" working immediately - programs can
>> still log to syslogd until the logging socket buffer fills up.
>> Which can be _damn_ frsutrating to find (I haven't seen this
>> behaviour lately, but I remember being perplexed like hell a long
>> time ago).
>
>That'll do it. Gene, could you check on syslogd too, then?
>
See my reply to Linus.
>
>-- wli

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

