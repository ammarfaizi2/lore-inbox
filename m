Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270255AbUJTBD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270255AbUJTBD2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270252AbUJTA7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:59:46 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:2747 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S270214AbUJTAmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:42:42 -0400
Date: Wed, 20 Oct 2004 02:42:16 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: Jerome Borsboom <j.borsboom@erasmusmc.nl>,
       lkml <linux-kernel@vger.kernel.org>, george@mvista.com
Subject: Re: process start time set wrongly at boot for kernel 2.6.9
In-Reply-To: <1098216701.20778.78.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0410200233280.9510@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>
 <1098216701.20778.78.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004, john stultz wrote:

> On Tue, 2004-10-19 at 11:21, Jerome Borsboom wrote:
> > Starting with kernel 2.6.9 the process start time is set wrongly for 
> > processes that get started early in the boot process. Below is a dump from 
> > my 'ps' command. Note the start time for processes 1-12. After process 12 
> > the start time is set right.
> 
> How reproducible is this? Are the correct and incorrect time values
> always off by the same amount? 
> 
> Are you running NTP? I'm curious if you are changing your system time
> during boot. 

I'd bet that some process early in the boot adjusts your system time.
Then this is expected behavior. This is why I would have preferred the 
simple back-out patch for the boot times problem.

I'm sorry I fell of the net for so long and didn't stand up for the 
simpler change in this case. Oh well.

I'll probably supply a back-out patch for -mm then, after wading through
my multi-megabyte email backlog (sorry John, still need to read your time
keeping proposal and all its discussion).

Tim
