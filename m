Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUBZFsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 00:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbUBZFsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 00:48:11 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:44785 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262698AbUBZFsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 00:48:09 -0500
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: johnl@aurema.com
Content-Type: text/plain
Organization: 
Message-Id: <1077766232.10393.992.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Feb 2004 22:30:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Lee writes:

> The usage rates for each task are estimated using Kalman
> filter techniques, the  estimates being similar to those
> obtained by taking a running average over twice the filter
> _response half life_ (see below). However, Kalman filter
> values are cheaper to compute and don't require the
> maintenance of historical usage data.

Linux dearly needs this. Please separate out this part
of the patch and send it in.

Right now, Linux does not report the recent CPU usage
of a process. The UNIX standard requires that "ps"
report this; right now ps substitutes CPU usage over
the whole lifetime of a process.

Both per-task and per-process (tid and tgid) numbers
are needed. Both percent and permill (1/1000) units
get reported, so don't convert to integer percent.


