Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266234AbUFUN40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUFUN40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266235AbUFUN40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:56:26 -0400
Received: from ida.rowland.org ([192.131.102.52]:1284 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S266234AbUFUN4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:56:25 -0400
Date: Mon, 21 Jun 2004 09:56:25 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Best way to get a 250 us delay?
Message-ID: <Pine.LNX.4.44L0.0406210952221.1277-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the best way for a driver running in process context to get a 
middle-length delay, say around 250 microseconds?  By "best", I mean:

	(A) Minimum processor utilization;

	(B) Minimum latency (additional delay beyond the amount 
	    requested).

I realize that these criteria are in conflict and some balance needs to be 
found.  Perhaps the best answer for (A) is msleep(1) or the equivalent, 
while the best answer for (B) is udelay(250).  Are there other 
possibilities that might work out better?

Alan Stern

