Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270085AbTHGRmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270234AbTHGRmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:42:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41204 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S270085AbTHGRlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:41:21 -0400
Subject: Re: Interactivity improvements
From: Robert Love <rml@tech9.net>
To: Patrick McLean <pmclean@cs.ubishops.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F3261A2.9000405@cs.ubishops.ca>
References: <3F3261A2.9000405@cs.ubishops.ca>
Content-Type: text/plain
Message-Id: <1060278078.15243.71.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-2) 
Date: Thu, 07 Aug 2003 10:41:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 07:26, Patrick McLean wrote:

> Finally, the interactivity estimator seems to be quite a bit of code, 
> which certain people have no real useful (in servers for example) and I 
> would imagine that it does reduce throughput

Actually, it should improve I/O throughput. What it might hurt is
computational performance, but only at the expense of benefiting other
processes.

The reason it benefits throughput is that file I/O is definitely marked
interactive, and that results in file I/O being able to quickly wake up,
dispatch the I/O, and go back to sleep. Its the usual treatment given to
I/O, and it works.

	Robert Love


